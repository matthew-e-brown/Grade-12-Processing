color BG = (200); //Pick a solid, light color for the background.
int p = 0; //This global variable represents how many squares the user has clicked on. 
int numCor = 0; //This is a global variable which represents how many the user got correct when compared against the computer's choices.
boolean answersPicked = false; //This is fairly self explanatory. It is used to enable the feature that deselects squares when the user clicks again.

Square grid[][] = new Square[7][7]; //Declare a new two dimensional array: 7 rows, 7 columns.
Square goButton; //Declare the go buttpn.

void setup() {
  size(1180, 800);
  float spacing = width*0.075; //make a variable that is easily changeable that changes how far apart the squares on the grid are.

  //create the grid of squares;
  int t = 1;
  //t is used to number each of the squares (the numbers are purely for show, the program uses spots in the array to determine squares).
  for (int r = 0; r < 7; r++) {
    for (int c = 0; c < 7; c++) {
      //every time you see this set of for loops, r & c stand for row and column respectively. Basically, it's
      //"do this thing for every column (up & down) for every row (left & right), since each row contains 7 columns.

      grid[r][c] = new Square(
        spacing*0.1 + (c*spacing), //x pos of square
        spacing*0.1 + (r*spacing), //y pos of square
        width/14, //width
        width/14, //height
        color(190), //"BLANK" -- which means the normal color of the square
        color(100, 255, 100) //"SELECTED" -- which is fairly self-explanatory. Color when picked by user.
        );
      grid[r][c].SPOT = t;
      //SPOT is a class variable which is just converted to the text on each square.
      t++;
    }
  }
  //make the goButton square
  goButton = new Square( 
    spacing*0.1 + (7.2*spacing), //x pos
    spacing*0.1, //y pos
    width/14, //w
    width/14, //h
    color(0, 255, 0), //BLANK
    color(50, 255, 50) //SeLECTED
    );
  goButton.REG = false;
  //REG tells the Square class whether to use a number for the squares text, or to use the word "GO".
}

void mouseClicked() {
  if (mouseButton == LEFT) {

    if (answersPicked) {
      //this resets the squares once the user clicks again.
      //this makes it so that they can't pick squares after the computer. Cheaters.
      for (int r = 0; r < 7; r++) {
        for (int c = 0; c < 7; c++) {
          grid[r][c].answer = false;
          //set every one of the square to not an answer.
          answersPicked = false;
          //tell the computer that the answers are no longer picked.
        }
      }
    }

    for (int r = 0; r < 7; r++) {
      for (int c = 0; c < 7; c++) {
        if (grid[r][c].mouseOver && !grid[r][c].selected && p < 6) {
          //this if (paired with the for loops, remember that they mean everything within is done for each square) statement checks if the user is:
          // a) hovering over every square
          // b) if every square is selected
          // c) if they've picked less than six
          grid[r][c].selected = true;
          //now they've picked it
          p++;
          //increase the number they've picked
        } else if (grid[r][c].mouseOver && grid[r][c].selected && p >= 0) {
          //this works the same as the last one, but it checks if they have more than 0 picked
          grid[r][c].selected = false;
          //they've unselected it
          p--;
          //lower the number they've selected
        }
      }
    }

    if (goButton.mouseOver && p == 6) { //makes it so they can only hit GO after picking 6 squares
      answerGen(); //see tab Answer_functions
    }
  }
}

void draw() {
  answerCheck(); //see tab Answer_functions
  background(BG);
  for (int r = 0; r < 7; r++) {
    for (int c = 0; c < 7; c++) {
      grid[r][c].mouseCheck(); //check if Mouse is over top of square
      grid[r][c].display(); //draw the square
    }
  }

  if (p < 6) { //this block changes the color to green from gray when 6 have been picked, indicating readiness
    goButton.BLANK = color(255, 255, 255, 128);
  } else {
    goButton.BLANK = color(0, 255, 0, 255);
  }

  goButton.mouseCheck();
  goButton.display();

  textAlign(TOP, LEFT);
  textSize(32);
  text(numCor + " squares correctly guessed.", goButton.x+goButton.w*0.5, goButton.y+goButton.h*3);
  textSize(30);
  text("Pick 6 squares and hit \"GO.\"", goButton.x+goButton.w*0.5, goButton.y+goButton.h*4);
}