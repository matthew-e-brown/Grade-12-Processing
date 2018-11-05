class Object { //The parent class of all objects that have Forces applied to them. This is where physics is simulated.
  PVector pos, vel, acc, drag;
  float w, h, mass, p; //width, height, mass, density (p = rho)
  float angle;
  int timeAlive;
  Object(float x, float y, float w, float h) {
    this.w = w;
    this.h = h;

    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    p = 0.1; //p represents Rho, or the density
    mass = (w*h)*p;
  }

  void applyForce(PVector Fapp) { // F = ma therefore a = F/m, accumulate all the accelerations and apply it to velocity as derivative
    PVector Fa;
    Fa = Fapp.copy();
    Fa.div(mass);

    acc.add(Fa); //Accumulate the force onto the acceleration, to get Fnet and not 1 Force
  }

  PVector calculateDrag(PVector vel, float mu) {
    //In real life:
    //Fdrag = 1/2 * density * vel squared * coefficient of drag * crossectional area
    //Thus:
    PVector drag = vel.copy();
    float speed = vel.mag();
    drag.normalize();
    drag.mult(-1*0.5);
    drag.mult(mu * speed * speed);
    return drag;
  }

  void edges() { //Checks the center of the given object against the edges of the screen
    if (pos.x > width) {
      pos.x = width;
      vel.x *= -1;
    } else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    }
    if (pos.y > height) {
      pos.y = height;
      vel.y *= -1;
    }
    if (pos.y <= 0) {
      vel.y *= -1;
    }
  }

  void update() {
    //edges();
    timeAlive++;
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
}
