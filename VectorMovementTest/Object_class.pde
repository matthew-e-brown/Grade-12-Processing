class Object {
  PVector pos, vel, acc;
  float w, h;
  float mass;
  float density = 0.5;

  Object(float x, float y, float w, float h) {
    mass = (w*h) * density / 250;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }

  void applyForce(PVector appliedForce) {
    PVector Fa = appliedForce.copy();
    Fa.div(mass);
    acc.add(Fa);
  }

  void edges() {
    if (pos.x >= width || pos.x <= 0) {
      vel.x *= -1;
    }
    if (pos.y >= height || pos.y <= 0) {
      vel.y *= -1;
    }
  }

  void update() {
    edges();
    vel.add(acc);    
    pos.add(vel);

    acc.mult(0);
  }

  void display() {
    pushMatrix(); 
    {
      translate(pos.x, pos.y);
      ellipse(0, 0, w, h);
    }
    popMatrix();
  }
}
