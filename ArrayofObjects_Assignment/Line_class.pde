class Line {
  float x, y, w, l, SPEED;
  int dir;
  boolean mouseOver = false;
  boolean clicked = false;
  
  Line(float x_, float y_, float w_, float l_, int dir_, float SPEED_) { //Constructor function
    x = x_;
    y = y_;
    w = w_;
    l = l_;
    dir = dir_;
    SPEED = SPEED_;
  }

  void display() {

    // Changes the color if the rectangle has been clicked on
    if (!clicked) {
      fill(255);
    } else if (clicked) {
      fill(255, 150, 150);
    }

    noStroke();
    rectMode(CENTER);
    // Draws the rectangle (different l & w depending on the direction)
    if (abs(dir) == 1) {
      rect(x, y, w, l);
    } else if (abs(dir) == 2) {
      rect(x, y, l, w);
    }
  }


  void update() {

    // These if statements shoot the line in the desired direction
    if (dir == 1) {
      y-=SPEED;
    } else if (dir == -1) {
      y+=SPEED;
    } else if (dir == 2) {
      x-=SPEED;
    } else if (dir == -2) {
      x+=SPEED;
    }

    // This block makes the lines change direction when they hit a wall
    if (dir == 1 && y <= 0 + (l*0.5)) {
      dir = dir*-1;
    } else if (dir == -1 && y >= height - (l*0.5)) {
      dir = dir*-1;
    } else if (dir == 2 && x <= 0 + (l*0.5)) {
      dir = dir*-1;
    } else if (dir == -2 && x >= width - (l*0.5)) {
      dir = dir*-1;
    }

    // This block of if statements checks collisions
    // See .txt file in the sketch's directory.
    if (abs(dir) == 1) { // For rects up/down
      if ((mouseX > x - 0.5*w) && (mouseX < x + 0.5*w) && (mouseY > y - 0.5*l) && (mouseY < y + 0.5*l)) {
        mouseOver = true;
      } else {
        mouseOver = false;
      }
    } else if (abs(dir) == 2) { // For rects L/R
      if ((mouseX > x - 0.5*l) && (mouseX < x + 0.5*l) && (mouseY > y - 0.5*w) && (mouseY < y + 0.5*w)) {
        mouseOver = true;
      } else {
        mouseOver = false;
      }
    }
  }
}
