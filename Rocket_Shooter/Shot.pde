class Shot extends Object {
  String parent;
  color ACCENT;
  
  //When the When the rocket shoots, it passes "this" (itself) as a parameter
  Shot(Rocket parent) {
    super(parent.getRocketNose().x, parent.getRocketNose().y, 10*SCALE, 10*SCALE); //Create a new "object" at the rocket's nose
    ACCENT = parent.ACCENT;
    this.parent = parent.ID;

    p = 0.5;
    mass = PI*pow(w, 2)*p;
  }

  void update() { //pos.vel.acc
    edges();
    super.update();
  }

  void edges() { //Check top and bottom, and left and right
    if (pos.y <= 0) {
      pos.y = 0 + h;
      vel.y *= -0.75;
    }
    if (pos.y >= height) {
      pos.y = height - h;
      vel.y *= -0.75;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.x > width) {
      pos.x = 0;
    }
  }

  void display() {
    pushMatrix();
    {
      translate(pos.x, pos.y);
      rotate(radians(angle));

      fill(ACCENT);
      stroke(0);
      ellipse(0, 0, w, h);
    }
    popMatrix();
  }
}
