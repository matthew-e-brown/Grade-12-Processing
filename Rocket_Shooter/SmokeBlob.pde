class SmokeBlob extends Object {
  color FILL;
  SmokeBlob(float x, float y, float w, float h) {
    super(x, y, w, h);
    p = 0.005;
    mass = PI*pow(w, 2)*p;
    FILL = color(random(220, 255));
  }

  void update() {
    super.update();
    float mu = ((w+h)*p)/25;
    PVector drag = calculateDrag(vel, mu);
    applyForce(drag);
    timeAlive++;
  }

  void display() {
    pushMatrix();
    {
      translate(pos.x, pos.y);
      if (timeAlive <= 15) {
        fill(FILL, map(timeAlive, 0, 15, 0, 25));
      } else {
        fill(FILL, map(timeAlive, 15, smokeTrailLength-2, 25, 0));
      }
      noStroke();
      ellipse(0, 0, map(timeAlive, 0, smokeTrailLength, w, w*4), map(timeAlive, 0, smokeTrailLength, h, h*4));
    }
    popMatrix();
  }
}
