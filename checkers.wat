(module
    (memory $mem 1)
    (func $indexForPosition (param $x i32)(param $y i32)(result i32))
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