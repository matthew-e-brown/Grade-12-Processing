class Button {
  float x, y, w, h, SIZE;
  String text;
  color FILL, STROKE;

  Button(float x_, float y_, float w_, float h_, String text_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    FILL = color(128, 230, 128);
    STROKE = color(255, 255, 128);
    SIZE = 22 * SCALE;
  }
  
  boolean mouseOver() { //Checks collisions for each button with the mouse
    boolean wid = false;
    boolean hei = false;

    if (mouseX > x-0.5*w && mouseX < x+0.5*w) wid = true;
    if (mouseY > y-0.5*h && mouseY < y+0.5*h) hei = true;
    if (wid && hei) return true;
    else return false;
  }

  void display() {

    if (mouseOver()) {
      stroke(STROKE);
      strokeWeight(2*SCALE);
    } else if (!mouseOver()) {
      noStroke();
    }

    fill(FILL);
    rectMode(CENTER);
    rect(x, y, w, h);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(SIZE);
    text(text, x, y-h*0.1);
  }
}
