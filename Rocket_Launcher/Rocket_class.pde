class Rocket {
  float x, y, s, accel;
  boolean launched = false;
  color fill, stroke;
  int w, h;
  {w = 15; h = 30;}

  Rocket (float x_, float y_, float accel_, color fill_, color stroke_) {
    x = x_;
    y = y_-h; 
    s = 0;
    accel = accel_;
    fill = fill_;
    stroke = stroke_;
  }

  void move() {
    if (launched) {
      if (s <= height/30) {//max speed
        s += accel;
      }

      y -= s; //move

      if (y< -(1.6*h)) { //top of screen
        y = height+(1.5*w);
        launched = false;
        s = 0;
        rocketScore++;
      }
    } 
    if (!launched && y > height-h) { //rising up from the dead
      s += accel;
      y -= s;
    }
    if (y == height-h) { //done rising back up
      s = 0;
      y = height-h; //just in case
    }
  }

  void display() {
    rectMode(CORNER);
    stroke(stroke);
    fill(fill, map(y, height, 0, 255, 200));

    rect(x, y, w, h); //body

    triangle(x, y, x+(0.5*w), y-(1.5*w), x+w, y); //nose

    triangle(x, y+(h*0.8), x-(0.5*w), y+h, x, y+h); //left fin
    triangle(x+w, y+(h*0.8), x+(1.5*w), y+h, x+w, y+h); //right fin

    fill(255, 128, 0); //flame fill
    noStroke();
    triangle(x, y+h, x+(0.5*w), y+(h*1.4), x+w, y+h); //flame
  }
}