Drop[] droplist = new Drop[1500];

void setup() {
  //fullScreen();
  size(1500, 1000);
  for (int i = 0; i < droplist.length; i++) {
    droplist[i] = new Drop(
      random(4.5, 5.5), //wind value the i'th drop
      abs((randomGaussian()*12)), //speed y
      width*i/droplist.length, //starting pos x
      random(-100, height) //starting pos y
      );
  }
  frameRate(25);
}

void draw() {
  background(#505050);
  for (int i = 1; i < droplist.length; i++) {
    droplist[i].dropDraw();
    droplist[i].rainFall();
  }
}

class Drop {
  //positive wind is right
  float speedX, speedY, posX, posY, posZ;

  Drop(float in_speedX, float in_speedY, float in_posX, float in_posY) {
    //float
    speedX = in_speedX;
    speedY = in_speedY;
    posX = in_posX;
    posY = in_posY;
    posZ = in_speedY*0.02; //depth is based on it's fall speed
  }

  void rainFall() {
    posY += speedY;
    posX += speedX*posZ;

    if (posY >= height) {
      posY = random(-50, -100);
    }
    if (posX >= width) {
      posX = random(-1, -5);
    }
    
  }
  void dropDraw() {
    noStroke();
    fill(#3E9AE3);
    rect(posX, posY, 2*posZ, 80*posZ);
  }
}
