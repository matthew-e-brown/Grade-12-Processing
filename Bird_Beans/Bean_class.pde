class Bean {
  PVector position, velocity;
  PImage BEAN;

  float curAngle = 0;
  float angleAdd;
  float maxAngle = 10;
  int curFrame;

  Bean(float x, float y, float yspeed, String spriteName) {
    position = new PVector(x, y);
    velocity = new PVector(0, yspeed);
    BEAN = loadImage("Sprites/"+spriteName+".png");
    BEAN.resize(int(BEAN.width*SCALE), int(BEAN.height*SCALE));
    beanRadius = 0.25*BEAN.width;

    angleAdd = map(yspeed, 1*SCALE, 20*SCALE, 1, 5);
    curFrame = 0;
  }

  void update() {
    position.add(velocity);
    curFrame++;
    if (curFrame % 2 == 0) {      
      if (abs(curAngle) >= maxAngle) {
        angleAdd *= -1;
      }
      curAngle += angleAdd;
    }
  }

  void display() {
    pushMatrix();
    imageMode(CENTER);
    translate(position.x, position.y);
    rotate(radians(curAngle));
    image(BEAN, 0, 0);
    imageMode(CORNER);
    popMatrix();
    //ellipse(position.x, position.y+0.5*(beanRadius), BEAN.width, BEAN.height);
  }
}
