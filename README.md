# snake-IV-SEM

In this repo I would like to present you a simple snake game produced using MIPS assembler language.
In order to run this code you have to download free MARS MIPS simulator, open file, assembly it and then have fun

Size of (graphic) board is 20x20 blocks, but you have to create 22x22 blocks array in order to draw borders. After every move using "w", "s", "a", "d"
the new board is printed. Game has built-in collision system, which doesn't allow player to move through walls. At the beggining the snake and fruit
is placed randomly on board.

The mechanic of a game is based on two additional arrays (size 100 each):
  1. first - stores an address of cell on graphic board, where snake's head changes direction
  2. second - stores an ASCII code of new direction (119 - w, 115 - s, 97 - a, 100 - d)
