class Spot {
  PVector position, velocity;
  color FILL;
  Spot(float x, float y, float sx, float sy) {
    position = new PVector(x, y);
    velocity = new PVector(sx, sy);
    FILL = color(255, 255, 255, 100);
  }
  
  void display() {
    fill(FILL);
    noStroke();
    ellipse(position.x, position.y, spotWidth, spotWidth);
  }
  
  void move() {
    position.add(velocity);
    if (position.y > height-spotWidth/2 || position.y < 0 + spotWidth/2) {
      velocity.y = velocity.y * -1;
    }
    if (position.x > width-spotWidth/2 || position.x < 0 + spotWidth/2) {
      velocity.x = velocity.x * -1;
    }
  }
  
}
