class Button {
  float x, y, w, h;
  color FILL, STROKE;
  Textblock text;

  Button(float x, float y, float w, float h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //Textblock(String text, float size, float x, float y, boolean dropShadow
    this.text = new Textblock(text, w/7 * SCALE, x, y, true);
    FILL = color(128, 230, 128);
    STROKE = color(255, 255, 128);
  }
  
  boolean mouseOver() { //Checks collisions for each button with the mouse
    boolean wid = false;
    boolean hei = false;

    if (mouseX > x-0.5*w && mouseX < x+0.5*w) wid = true;
    if (mouseY > y-0.5*h && mouseY < y+0.5*h) hei = true;
    if (wid && hei) return true;
    else return false;
  }

  void display() { //Draws the button
    if (mouseOver()) {
      stroke(STROKE);
      strokeWeight(8*SCALE);
    } else if (!mouseOver()) {
      noStroke();
    }

    fill(FILL);
    rectMode(CENTER);
    rect(x, y, w, h);

    fill(255);
    textAlign(CENTER, CENTER);
    text.display();
    strokeWeight(1);
  }
}
