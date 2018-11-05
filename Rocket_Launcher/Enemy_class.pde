class Enemy {
  //floats
  float x, y, sx, sy, accel;
  //colors
  color fill;
  int w, h;
  {w = 40; h = 40;}

  Enemy(float x_, float y_, float sx_, float sy_, float accel_, color fill_) {//constr.
    //floats
    x = x_;
    y = y_;
    sx = sx_;
    sy = sy_;
    accel = accel_;
    //colors
    fill = fill_;
  }

  void move() {
    sx += accel;
    x += sx;
    sy -= accel;
    y += sy;

    if (y+h > height*(2.00/8.00) || y < height*(1.00/8.00)) {
      sy = sy*-1;
    }

    if (x > width) {
      x = 0-w;
    }
    if (x+w < 0){
      x = width;
    }
  }

  void display() {
    fill(fill);
    ellipseMode(CORNER);
    ellipse(x, y, w, h);
  }
}