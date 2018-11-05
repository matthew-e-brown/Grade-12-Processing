class Debris {
  PVector position, velocity, GRAVITY;
  int colorPos;
  
  Debris(float x, float y, float xspeed, float yspeed) {
    position = new PVector(x, y);
    velocity = new PVector(xspeed, yspeed);
    GRAVITY = new PVector(0, 0.981*SCALE);
    
    colorPos = 0;
  }
  
  void update() {
    velocity.add(GRAVITY);
    position.add(velocity);
    if (colorPos != 4) colorPos++;
    else colorPos = 0;
  }
  
  void display() {
    noStroke();
    if (colorPos == 0) fill(#FFADFB, 250);
    else if (colorPos == 1) fill(#268AEA, 250);
    else if (colorPos == 2 || colorPos == 4) fill(#FFFFFF, 250);
    else if (colorPos == 3) fill(#FFFF64, 220);
    rect(position.x, position.y, 10*SCALE, 10*SCALE);
  }
  
}
