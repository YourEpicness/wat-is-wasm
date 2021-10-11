# Notes

### S-expression

- code in webassembly is written in modules. everything starts with a module like `module (memory 1) (func))`

### Bit flags
- everything is in linear memory so we only have access to 32 bits(4 bytes)
- we can represent state using bit flags
- bit flags - a technique for assigning meaning to individual bits within a number
- when multiple bits are combined for another meaning, its called bit masking

### Bitwise operators
- just good ol logical operators but with bits represented as 1s and 0s.
- bitwise AND - compares each bit of one number to second number, if both are in same position as 1, then result is 1 (true)
- bitwise Or - just Or version
- bitwise XOR - exlusive or

### Bit-checkers
- piece types(arent everything) are represented in numbers
- we assign meaning based on numbers

### Crowning Functions
- cant use XOR in case of need for bitmasking as it would toggle state
- somehow AND with a mask fixes all our problems??
- we check the position of the 1s of the actual value, then compare it to the mask using whatever bitwise operation and we get our result depending of if the 1s and 0s are in the right spots

### New Statements
- Block statement - used to wrap things and specify a return type
- inRange - used to prevent querying out of the bounds

### Checking Turns
- we created a bunch of functions because crowned pieces can mess up equality
- so instead we use an AND check for determing whos currentTurn it is
- in high level, comparing player.color to currentturn.color