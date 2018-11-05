class Explosion {
  float x, y;
  int w, h, dur, startTime, endTime;

  Explosion(Rocket r_, Enemy e_) { //constr.
    x = r_.x;
    y = r_.y;
    w = r_.w;
    h = r_.h;

    dur = int(abs(e_.sx) * abs(e_.sy))*1000;
    startTime = millis();
    endTime = startTime + dur;
  }

  void display() {
    ellipseMode(CORNER);
    fill(255, 255, 35);
    ellipse(x+(0.8*w), y+(0.8*h), w*0.8, h*0.8);
    fill(255, 10, 10);
    ellipse(x, y, w, h);
  }
}