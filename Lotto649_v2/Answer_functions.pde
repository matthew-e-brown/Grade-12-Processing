void answerGen() {
  int answersGend = 0;

  // this block makes it so that the computer clears the previous answers before getting new ones 
  // cc/cr stand for correct column/correct row
  for (int i = 0; i < 6; i++) {
    for (int r = 0; r < 7; r++) {
      for (int c = 0; c < 7; c++) {
        grid[r][c].answer = false;
      }
    }
  }

  // this block will make the new answers. The while loop coupled with the variable
  // answersGend and the if statement that only follows through if the answer is a new answer
  // make it so that the same answer is not picked twice by the computer.
  while (answersGend < 6) {  
    int cc = floor(random(0, 7));
    int cr = floor(random(0, 7));
    // generate a random column and row, and therefore a random square.

    if (!grid[cr][cc].answer) { //check if the random square isn't already picked
      grid[cr][cc].answer = true;
      answersGend++; //increase the number of answers picked
    }
  }
  answersPicked = true; //tell the computer that answers have been selected
}

void answerCheck() {
  numCor = 0;

  //fairly simple. Checks every square to see if it was selected by both the comptuer and user
  // this is easy because the "selected" and "answer" are stored within each object.
  for (int r = 0; r < 7; r++) {
    for (int c = 0; c < 7; c++) {
      if (grid[r][c].selected && grid[r][c].answer) {
        grid[r][c].correct = true;
        numCor++; //used to keep track of how many the user got right.
      }
      if (!(grid[r][c].selected && grid[r][c].answer)) {
        grid[r][c].correct = false;
      }
    }
  }
}