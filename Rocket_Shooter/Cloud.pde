class Cloud extends Object { //Just a simple blob that extends Object so that it has p,v,a and force funcitons
  color FILL;
  Cloud(float x, float y, float w, float h) {
    super(x, y, w, h);
    FILL = color(255, 20);
    p = 0.001;
    mass = (PI*pow(w, 2))*p;    
  }
  
  void update() { //Applies the forces, and then adds a to v, and v to a
    edges();
    super.update();
  }
  
  void edges() { //Checks when the cloud hits the edge of the screen
    float farLeft = pos.x - w*0.5;
    float farRight = pos.x + w*0.5;
    if (farLeft > width) pos.x = -w*0.5;
    if (farRight < 0) pos.x = width + w*0.5;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));
    {
      noStroke();
      fill(FILL);
      ellipse(0, 0, w, h);
    }
    popMatrix();
  }
}
