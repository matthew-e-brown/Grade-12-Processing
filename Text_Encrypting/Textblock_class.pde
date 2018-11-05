class TextBlock { //simply makes it easy to put text in one location by spacing in a class instead of the draw function
  float x, y, size;
  String[] textLines;
  String allText;
  color fillColor;

  TextBlock(float x_, float y_, float size_, color fillColor_, String allText_) {
    x = x_;
    y = y_;
    size = size_;
    fillColor = fillColor_;
    allText = allText_;
  }

  void display() {
    textLines = split(allText, "/NL");
    fill(fillColor);
    textSize(size);
    for (int i = 0; i < textLines.length; i++) {
      text(textLines[i], x, y+((size*(float(35)/float(24)))*i));
    }
  }
}
