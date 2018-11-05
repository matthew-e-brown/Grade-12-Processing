void setup() {
  size(800, 800);
}

void draw() {
  
}

class Tile {
  boolean mine, discovered;
  int index, nearby;
  float x, y;
  Tile(float x, float y) {
    mine = false;
    discovered = false;
  }
}
