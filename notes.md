# Notes

### S-expression

- code in webassembly is written in modules. everything starts with a module like `module (memory 1) (func))`

### Bit flags
- everything is in linear memory so we only have access to 32 bits(4 bytes)
- we can represent state using bit flags
- bit flags - a technique for assigning meaning to individual bits within a number
- when multiple bits are combined for another meaning, its called bit masking

Bitwise operators
- just good ol logical operators but with bits represented as 1s and 0s.
- bitwise AND - compares each bit of one number to second number, if both are in same position as 1, then result is 1 (true)
- bitwise Or - just Or version
- bitwise XOR - exlusive or

Bit-checkers
- piece types(arent everything) are represented in numbers
- we assign meaning based on numbers