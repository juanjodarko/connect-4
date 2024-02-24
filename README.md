# Connect 4 Game

This is a fast implementation of the game connect 4, to run the game you need to run the following command

```shell
ruby connect4rb
```

## How it is built

### connect4.rb

This file contains the main interface to start the game flow. It gives the user the options to start the game.

### board.rb

The board file has the logic to create the board and update the view for the user.

I used a simple matrix to create the board. taking in account that this can take longer to analyze in a per row/column way in the game_judge.rb section you will see that, thanks to pattern recognition instead of column / row looping the game analysis is optimal.

----

#### pros

the pros of using the matrix approach is that it was faster to program as an MVP, and that the information saved was too simple to create something more complicated like a Cell class.

#### cons

as the information is not standardized we need to loop through all the matrix to get which spaces are occupied, in the worst case scenario this takes more time than having a cell class and keeping track of each in the board class.

-----

### game_judge.rb

this file contains all the information to check for a winner during a game, the judge checks after every turn for the patterns created in the matrix, making the analysis of the board better, it also detects when the game cannot continue, using the tie? method we can find patterns with a wildcard 'x' in the patterns to check if the remaining patterns with empty spaces are enough for any of the users to complete their winning pattern.

### player.rb

This file contains the base logic for a player, we have two types of players a cpu_player and the human player, the CPU player was created mainly to test the game during development, but it worked well, even though it has no code to analyze the next move. the Human player has it's own get_pos method which asks the user for a column to drop the token, also we get the end phase which is a small pause to let the user UNDO the last movement. I thought this method even though it was a bonus task, it felt like cheating during the game, so the mechanics of this feature is to let the user UNDO just after it's own turn and just once per turn. 

### utils.rb

This file only contains a little method to help me with the transpose operation, for pattern matching.



```shell
   =====================
      Connect 4 game   
   =====================
   Instructions:       
   1. Select a letter between A and G  
   2. You can UNDO before ending your turn but only once per turn
   3. To exit you can type Q during your turn 
   4. To win a player must have 4 tokens in a row/col/diagonal
   5. Enjoy the game! 
   ---------------------
   Remaining turns: 42
   ---------------------
 6 | || || || || || || |
 5 | || || || || || || |
 4 | || || || || || || |
 3 | || || || || || || |
 2 | || || || || || || |
 1 | || || || || || || |
   =====================
   |A||B||C||D||E||F||G|
**********************************************************************
red turn
**********************************************************************
Please select a column letter between A and G, to Exit use Q


```



