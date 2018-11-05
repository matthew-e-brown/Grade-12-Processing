//These variables keep track of which key is CURRENTLY pressed
boolean keyLeft, keyRight, keyUp, keyDown;
{
  keyLeft = false;
  keyRight = false;
  keyUp = false;
  keyDown = false;
}

float angleAdd; //The amount that the rotation changes by each frame when a key is pressed
float X, Y, Z; //The current amount of rotation applied by the box

float SCALE; //So that things aren't massive on something other than a 4K screen

void setup() {
  fullScreen(P3D); //P3D because I'm doing a box
  size(800, 600, P3D);
  SCALE = (width+height)/255*0.05; //base scale of w & h
  
  //Call these in setup because they're going to remain the same, and
  //calling them each frame would hurt performance
  fill(255);
  stroke(200, 50, 50);
  strokeWeight(20*SCALE);
  
  frameRate(60);
}

void draw() {

  //Amount that the angle changes is based on the framerate, so that if the program slows then the box is relative
  angleAdd = frameRate/30;

  //This was mostly trial and error to figure out which key should go with which direction.
  //Keep in mind that Y and X are the CURRENT angle being changed by a (normally) constant value.
  if (keyLeft) Y -= angleAdd;
  if (keyRight) Y += angleAdd;
  if (keyUp) X -= angleAdd;
  if (keyDown) X += angleAdd;

  background(0);
  
  pushMatrix(); //This block moves the origin to the centre of the screen and then rotates based on the angles set by the keys
  {
    translate(width/2, height/2, 50);
    rotateX(radians(X));
    rotateY(radians(Y));
    rotateZ(radians(Z)); //As much as there are no keys rotating by Z, I wanted to have this here for futureproofing just in case
    box(1000*SCALE, 400*SCALE, 200*SCALE);
  } 
  popMatrix();
}


//Key pressed sets a boolean for each relevant key to true, and then actions are performed based on that boolean, rather than which key is pressed.
//This is better because it makes programming press & released functionality into the program for stop & go.
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keyLeft = true;
    } else if (keyCode == RIGHT) {
      keyRight = true;
    } else if (keyCode == UP) {
      keyUp = true;
    } else if (keyCode == DOWN) {
      keyDown = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keyLeft = false;
    } else if (keyCode == RIGHT) {
      keyRight = false;
    } else if (keyCode == UP) {
      keyUp = false;
    } else if (keyCode == DOWN) {
      keyDown = false;
    }
  }
}
