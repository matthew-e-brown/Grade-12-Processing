class TextBlock {
  String text;
  float size;
  PVector pos;
  boolean dropShadow;
  color fill, shadow;
  float opacity;

  TextBlock(String text, float size, float x, float y, boolean dropShadow) {
    this.text = text;
    this.size = size;
    this.dropShadow = dropShadow;
    this.fill = color(255);
    this.shadow = color(0);
    this.opacity = 255;
    this.pos = new PVector(x, y);
  }

  void display() {
    textSize(size);
    fill(shadow, opacity);
    text(text, pos.x, pos.y);
    fill(fill, opacity);
    text(text, pos.x-size*SCALE*0.18, pos.y-size*SCALE*0.18);
  }
}
