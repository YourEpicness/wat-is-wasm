(module
    (memory $mem 1)
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
    (func $offsetForPosition (param$x i32)(param $y i32)(result i32)
        ;;Multiply the indexForPosition using the x and y variables by 4
        (i32.mul
            (call $indexForPosition (get_local $x)(geT_local $y))
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
            (i32.and (get_local $piece i32)(get_global $WHITE))
            (get_global $WHITE)
        )
    )
    ;; Determine if a piece is black
    (func $isBlack (param $piece i32)(result i32)
        (i32.eq
            (i32.and (get_local $piece i32)(get_global $BLACK))
            (get_global $BLACK)
        )
    )
)

