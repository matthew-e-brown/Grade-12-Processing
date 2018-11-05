void setup() {
  size(500, 500);
  frameRate(60);
}

int bg = 69;
int speed = 5;
  
float posX = 0;
float posY = 0;

class Orb {
  float posX, posY, speed;
  char cUp, cDown, cLeft, cRight;
  boolean isUp, isDown, isLeft, isRight = false;
  Orb (float x, float y, float s, char c1, char c2, char c3, char c4) {
    posY = y;
    posX = x;
    speed = s;
    cUp = c1;
    cDown = c2;
    cLeft = c3;
    cRight = c4;
  }
  
  void keyPressed(){
    if (key == cUp) {     isUp = true;}
    if (key == cDown) {   isDown = true;}
    if (key == cLeft) {   isLeft = true;}
    if (key == cRight) {  isDown = true;}
    else {return;}
  }
  
  void keyReleased(){
    if (key == cUp) {     isUp = false;}
    if (key == cDown) {   isDown = false;}
    if (key == cLeft) {   isLeft = false;}
    if (key == cRight) {  isDown = false;}
    else {return;}
  }
 
  void update(){
    keyPressed();
    if (isUp){
      posY -= speed;
    } if (isDown){
      posY += speed;
    } if (isLeft){
      posX -= speed;
    } if (isRight){
      posX += speed;
    }
    keyReleased();
    ellipse(posX, posY, 20, 20);
  }
}

Orb ball1 = new Orb(200, 250, 5, 'w', 's', 'a', 'd');
Orb ball2 = new Orb(300, 250, 5, 'i', 'k', 'j', 'l');

void draw() {
  
  background(bg);
  ball1.update();
  ball2.update();
  
 /*if (mousePressed){
    background(bg);
    ellipse(posX, posY, (random(200,250)), random(200,250));
    fill(255,0,0);
    stroke(0,255,0);
    strokeWeight(10);
  } 
  else {
    background(bg);
    ellipse(posX, posY, 225, 225);
    fill(255,0,0);
    stroke(0,255,0);
    strokeWeight(10);
  }*/
}