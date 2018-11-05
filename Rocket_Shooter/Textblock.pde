class Textblock { //This is used mostly to enable dropshadows automatically on my text
  String text;
  float size;
  PVector pos;
  boolean dropShadow;
  color fill, shadow;
  float opacity;

  Textblock(String text, float size, float x, float y, boolean dropShadow) {
    this.text = text;
    this.size = size;
    this.dropShadow = dropShadow;
    this.fill = color(255);
    this.shadow = color(45);
    this.opacity = 255;
    this.pos = new PVector(x, y);
  }

  void display() {
    textSize(size);
    if (dropShadow) { //Draw it under the main text first
      fill(shadow, opacity);
      text(text, pos.x+size*0.1, pos.y+size*0.1);
    }
    fill(fill, opacity);
    text(text, pos.x, pos.y);
  }
}
