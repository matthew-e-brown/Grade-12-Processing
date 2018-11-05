float test;
floatSlider s;
void setup() {
  size(1600, 1600);
  test = 50;
  s = new floatSlider(width/2, height/2, width/2, height/40);
  s.setVar(test, 0, 100);
}

void draw() {
  background(200);
  if (s.mouseOver() || s.held) cursor(HAND);
  else cursor(ARROW);
  s.update();
  s.display();

  test = s.getVar();

  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(test, width/2, height*5/8);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (s.mouseOver()) s.held = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    s.held = false;
  }
}

class floatSlider {
  float x, y, w, h;
  float min, max;
  float var;
  float sliderpos;
  boolean held = false;
  floatSlider(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void setVar(float var, float min, float max) {
    this.var = var;
    this.min = min;
    this.max = max;
    this.sliderpos = map(var, min, max, x-w/2, x+w/2);
  }

  float getVar() {
    return var;
  }

  boolean mouseOver() {
    if (dist(mouseX, mouseY, sliderpos, y) <= h) return true;
    else return false;
  }

  void update() {
    if (held) {
      sliderpos = constrain(mouseX, x-w/2, x+w/2);
      var = map(sliderpos, x-w/2, x+w/2, min, max);
    }
  }

  void display() {
    pushMatrix();
    {
      rectMode(CENTER);
      translate(x, y);
      stroke(0);
      fill(255);
      rect(0, 0, w*0.985, h*0.5);
      ellipse(sliderpos-x, 0, h, h);
    }
    popMatrix();

    if (mouseOver() || held) {
      pushMatrix(); 
      {
        rectMode(CENTER);
        translate(sliderpos, y + h*2);
        fill(255);
        stroke(0);
        rect(0, 0, h*1.5, h*1.5);
        fill(0);
        textAlign(CENTER, CENTER);
        textSize(24);
        int roundvar = round(var);
        text(roundvar, 0, 0);
      } 
      popMatrix();
    }
  }
}
