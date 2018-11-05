class Cell {
  int neighbours;
  float x, y, w, h;
  boolean bomb, show;
  Cell(float x, float y) {
    this.x = x;
    this.y = y;
    w = 25;
    h = 25;
    
    neighbours = 0;
  }
  
  private void display() {
    
  }
}
