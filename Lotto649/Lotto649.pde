color BG = color(0);
int numClicked = 0;

int[] c_cols = new int[7];
int[] c_rows = new int[7];
int[] u_cols = new int[7];
int[] u_rows = new int[7];

Square squares[][] = new Square[7][7];
Square goButton;

void setup() {
  size(800, 800);

  float spacing = 100;

  for (int col = 0; col < 7; col++) {
    for (int row = 0; row < 7; row++) {
      squares[col][row] = new Square((width/2 - 3*(width/7)) + (col*spacing), spacing/2 + (row*spacing), 50, 50);
    }
  }
  
  goButton = new Square((width/2)-50, height*0.9, 100, 75);
  goButton.FILL = color(0, 255, 170);
  goButton.CLICKED = color(255, 0, 100);
}

void mousePressed() {

  //grid buttons
  for (int col = 0; col < 7; col++) {
    for (int row = 0; row < 7; row++) {
      if (squares[col][row].mouseOver && squares[col][row].clicked == false && numClicked < 6) {
        squares[col][row].clicked = true;
        numClicked++;
      } else if (squares[col][row].mouseOver && squares[col][row].clicked == true) {
        squares[col][row].clicked = false;
        numClicked--;
      }
    }
  }

  //go Button
  if (goButton.mouseOver) {
    clearSquares();
    for (int i = 0; i < 6; i++) {
      int c = generate();
      int r = generate();
      squares[c][r].FILL = color (255, 100, 100);
      
      c_cols[i] = c;
      c_rows[i] = r;
    }
  }
}

void draw() {
  background(BG);
  for (int col = 0; col < 7; col++) {
    for (int row = 0; row < 7; row++) {
      squares[col][row].update();
      squares[col][row].display();
    }
  }
  goButton.update();
  goButton.display();
}

int generate() {
  int export;
  export = int(random(0, 7));
  return export;
}

void clearSquares(){
  for (int col = 0; col < 7; col++){
    for (int row = 0; row < 7; row++){
      squares[col][row].FILL = (255);
    }
  }
}