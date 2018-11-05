class Image {
  PVector position;
  float size;
  PImage file;
  color STROKE1, STROKE2, stroke;
  Image(String IMGname, float size_) {
    size = size_;
    file = loadImage("Images/"+IMGname);
    file.resize(int(size), int(size));
    
    STROKE1 = color(128, 225, 128);
    STROKE2 = color(255, 255, 128);
    
  }
  
  void update() {
    if (mouseOver()) {
      stroke = STROKE2;
    } else if (!mouseOver()){
      stroke = STROKE1;
    }
  }
  
  boolean mouseOver() {
    boolean wid, hei;
    wid = false;
    hei = false;
    if (mouseX > position.x - 0.5*file.width && mouseX < position.x + 0.5*file.width) wid = true;
    if (mouseY > position.y - 0.5*file.height && mouseY < position.y + 0.5*file.width) hei = true;
    if (wid && hei) return true;
    else return false;
  }
  
  void display() {
    strokeWeight(10*SCALE);
    noFill();
    stroke(stroke);
    rectMode(CENTER);
    rect(position.x, position.y, file.width, file.height);
    image(file, position.x, position.y);
  }
  
}
