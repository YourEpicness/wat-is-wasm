(module
    (memory $mem 1)
    (global $currentTurn (mut i32)(i32.const 0))
    (global $WHITE i32 (i32.const 2))
    (global $BLACK i32 (i32.const 1))
    (global $CROWN i32 (i32.const 4))

    (func $indexForPosition (param $x i32)(param $y i32)(result i32)
        ;;Add the integers from x by the (y * 8)
        (i32.add
            (i32.mul
                (i32.const 8)
                (get_local $y)
            )
            (get_local $x)
        )
    )
    ;;Offset = ( x + y * 8) * 4
    (func $offsetForPosition (param $x i32)(param $y i32)(result i32)
        ;;Multiply the indexForPosition using the x and y variables by 4
        (i32.mul
            (call $indexForPosition (get_local $x)(get_local $y))
            (i32.const 4)
        )
    )
    ;; Determine if a piece has been crowned
    (func $isCrowned (param $piece i32)(result i32)
        ;; Check piece state and crown state set to determine if crowned
        (i32.eq
            (i32.and (get_local $piece)(get_global $CROWN))
            (get_global $CROWN)
        )
    )
    ;; Determine if a piece is white
    (func $isWhite (param $piece i32)(result i32)
        (i32.eq
            (i32.and (get_local $piece)(get_global $WHITE))
            (get_global $WHITE)
        )
    )
    ;; Determine if a piece is black
    (func $isBlack (param $piece i32)(result i32)
        (i32.eq
            (i32.and (get_local $piece)(get_global $BLACK))
            (get_global $BLACK)
        )
    )

    ;; Adds a crown to a given piece (no mut)
    (func $withCrown (param $piece i32)(result i32)
        ;; Determines if its a regular piece or has a crown already and returns 1
        (i32.or (get_local $piece)(get_global $CROWN))
    )
    ;; Removes a crown from a given piece (no mut)
    (func $withoutCrown (param $piece i32)(result i32)
        ;; Determines if its a regular piece and its value is 3 (white & black??)
        (i32.and (get_local $piece) (i32.const 3))
    )
    ;; Sets a piece on the board
    (func $setPiece (param $x i32)(param $y i32)(param $piece i32)
        ;; Stores a 32 bit integer in memory from the offsetForPosition function
        (i32.store
            (call $offsetForPosition
                (get_local $x)
                (get_local $y)
            )
        )
        ;; Stored as a piece
        (get_local $piece)
    )
    ;; Gets apiece from the board. Out of range causes a trap
    (func $getPiece (param $x i32)(param $y i32)(result i32)
        (if (result i32)
            (block (result i32))
            (i32.and
                (call $inRange
                    (i32.const 0)
                    (i32.const 7)
                    (get_local $x)
                )
                (call $inRange
                    (i32.const 0)
                    (i32.const 7)
                    (get_local $y)
                )
            )
        )
        (then
            (i32.load
                (call #offsetForPosition
                    (get_local $x)
                    (get_local $y)
                )
            )
        )
        (else
            (unreachable)
        )
    )

    ;; Detect if values are within range (inclusie high and low)
    (func $inRange (param $low i32)(param $high i32)
        (param $value i32)(result i32)
        (i32.and
            (i32.ge_s (get_local $value)(get_local $low))
            (i32.le_s (get_local $value)(get_local $high))
        )
    )

    ;; Get the current turn owner
    (func $getTurnOwner (result i32)
        (get_global $currentTurn)
    )

    ;; Set the turn owner
    (func $setTurnOwner(param $piece i32)
        (set_global $currentTurn (get_local $piece))
    )

    ;; Switch turn owner to other player at end of turn
    (func #toggleTurnOwner 
        (if (i32.eq (call $getTurnOwner)(i32.const 1))
            (then (call $setTurnOwner (i32.const 2)))
            (else (call $setTurnOwner (i32.const 1)))
        )
    )

    ;; Detemrine if its a players turn
    (func $isPlayersTurn (param $player i32)(result i32)
        (i32.gt_s
            (i32.and (geT_local $player)(call $getTurnOwner))
            (i32.const 0)
        )
    )
)

