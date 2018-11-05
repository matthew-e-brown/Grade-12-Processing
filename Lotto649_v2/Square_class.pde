class Square {
  float x, y, w, h;
  boolean mouseOver, selected, answer, correct;
  boolean REG = true;
  color BLANK, SELECTED, CORRECT;
  int SPOT; //place in the list of number 0 to 5 (6nums)

  {
    mouseOver = false;
    selected = false;
    answer = false;
    correct = false;
  }

  Square(float x_, float y_, float w_, float h_, color BLANK_, color SELECTED_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    BLANK = BLANK_;
    SELECTED = SELECTED_;
    CORRECT = color(100, 100, 255);
  }

  void mouseCheck() {
    //this if statement checks if the mouse is between each 
    //side of the square; if the mouse is over the square
    if ((mouseX>x && mouseX<x+w) && (mouseY>y && mouseY<y+h)) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }

  void display() {
    noStroke();
    strokeWeight(5);
    fill(BLANK);
    if (mouseOver && p < 6 ) {
      stroke(255, 255, 50, 255);
    }
    if (mouseOver && p >= 6) {
      stroke(255, 50, 50, 128);
    }
    if (selected) {
      fill(SELECTED);
    }
    if (answer) {
      fill(255, 100, 100);
    }
    if (correct) {
      fill(CORRECT);
      stroke(255, 255, 50, 255);
    }

    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(map(20, 0, 1000*800, 0, height*width));
    if (REG) {
      text(SPOT, x+(w/2), y+(h/2));
    } else {
      text("GO", x+(w/2), y+(h/2));
    }
  }
}