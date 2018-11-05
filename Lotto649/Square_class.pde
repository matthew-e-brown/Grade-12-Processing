class Square {
  float x, y, w, h;
  boolean mouseOver, clicked;
  color FILL, HOVER, CLICKED;

  {
    mouseOver = false;
    clicked = false;
  }

  {
    FILL = color(255, 255, 255);
    CLICKED = color(100, 255, 100);
  }

  Square(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void update() {
    if ((mouseX>x && mouseX<x+w) && (mouseY>y && mouseY<y+h)) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }

  void display() {
    noStroke();
    strokeWeight(3);
    if (!mouseOver && !clicked) {
      fill(FILL);
      rect(x, y, w, h);
    }
    if (clicked) {
      fill(CLICKED);
      rect(x, y, w, h);
    }
    if (mouseOver && !clicked) {
      fill(FILL);
      stroke(255, 255, 0);
      rect(x, y, w, h);
    }
    if (mouseOver && clicked) {
      fill(CLICKED);
      stroke(255, 255, 0);
      rect(x, y, w, h);
    }
  }
}