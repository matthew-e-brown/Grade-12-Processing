int J = 5;//global variable which is the number of rockets (and by extension, explosions)
int K = 8; //global variable which is the number of enemies
int r = 0; //global var. which is the current rocket waiting to be fired
int rocketTotal = 0; //global var. which is the total amount of rockets having been fired
int rocketScore = 0; //global var. which is the amount of rockets to make it to space
color curFill, curStroke; //need this to be global
PImage BG;
boolean paused = false;
float TEXTSCALEFACTOR = width*height/450;

Rocket[] rocketArray = new Rocket[J];
Enemy[] enemyArray = new Enemy[K];

void setup() {
  fullScreen();
  //size(2560, 1440);
  BG = loadImage("Background.png");
  BG.resize(width, height);

  for (int i = 0; i < rocketArray.length; i++) { //creates bnall the rockets
    rocketArray[i] = new Rocket(
      width*(i+1)/(rocketArray.length+1), //xpos start
      height, //ypos start (bottom of rocket)
      0.01, //acceleration
      255, // fill start
      0 // stroke start
      );
  }

  for (int i=0; i<enemyArray.length; i++) { //creates enemies
    enemyArray[i] = new Enemy( //float x_, float y_, float sx_, float, sy_, float accel_, color fill_, color stroke_
      random(0, width), //x pos
      random((height*(1/8.00)), (height*(2.00/8.00))), //y pos
      random(1, 10), //speed x
      random(-0.095, 0.095), //speed y
      0.001, //accel
      color(floor(random(50, 101))) //fill
      );
  }

  frameRate(60);
}

void draw() {
  image(BG, 0, 0);

  for (int i = 0; i < rocketArray.length; i++) {
    rocketArray[i].move();
    rocketArray[i].display();
  }
  for (int i = 0; i < enemyArray.length; i++) {
    enemyArray[i].move();
    enemyArray[i].display();
  }

  //pointer triangle shadow
  fill(0, 0, 0, 150);
  triangle(
    rocketArray[r].x+1, (rocketArray[r].y-2*rocketArray[r].w)-7, 
    rocketArray[r].x+0.5*rocketArray[r].w+1, (rocketArray[r].y-1.5*rocketArray[r].w)-7, 
    rocketArray[r].x+rocketArray[r].w+1, (rocketArray[r].y-2*rocketArray[r].w)-7
    );

  //pointer triangle
  if (rocketArray[r].launched) {
    fill(255, 35, 35);
  } else if (!rocketArray[r].launched) {
    fill(255, 255, 35);
  }
  triangle(
    rocketArray[r].x, (rocketArray[r].y-2*rocketArray[r].w)-8, 
    rocketArray[r].x+0.5*rocketArray[r].w, (rocketArray[r].y-1.5*rocketArray[r].w)-8, 
    rocketArray[r].x+rocketArray[r].w, (rocketArray[r].y-2*rocketArray[r].w)-8
    );

  //score text ↓
  textAlign(LEFT, TOP);
  if (rocketTotal > 0) {
    scoreText.allText = "Total Launches: " + rocketTotal + "/NLScore: " + rocketScore + "/NLEfficiency: " + floor((float(rocketScore)/float(rocketTotal))*100) + "%";
  } else {
    scoreText.allText = "Total Launches: " + rocketTotal + "/NLScore: " + rocketScore + "/NLEfficiency: 0%";
  }
  scoreText.display();

  //debug/game info text ↓
  textAlign(RIGHT, TOP);
  infoText.x = width;
  infoText.allText = (floor(frameRate))+" FPS/NL" + J + " Rockets/NL" + K + " Enemies";
  infoText.display();

  //controls text ↓
  textAlign(LEFT, CENTER);
  controlText.x = width/(TEXTSCALEFACTOR*4);
  controlText.y = height/2;
  controlText.display();

  //collisions checking
  for (int i = 0; i < rocketArray.length; i++) {
    for (int j = 0; j < enemyArray.length; j++) {
      if (((enemyArray[j].x < (rocketArray[i].x+rocketArray[i].w)) && ((enemyArray[j].x+enemyArray[j].w) > rocketArray[i].x)) && ((enemyArray[j].y < (rocketArray[i].y+rocketArray[i].h)) && ((enemyArray[j].y+enemyArray[j].h) > rocketArray[i].y))) {
        //rocket has hit!
        rocketArray[i].y = height+(1.8*rocketArray[i].w);
        rocketArray[i].launched = false;
        rocketArray[i].s = 0;

        enemyArray[j].sx = enemyArray[j].sx*0.95;
        enemyArray[j].sy = enemyArray[j].sy*0.95;
      }
    }
  }
}

void mousePressed() {

  if (mouseButton == LEFT && !rocketArray[r].launched) {
    paint("paint");
  }

  if (mouseButton == RIGHT && !rocketArray[r].launched) {
    paint("clear");
  }

  if (mouseButton == CENTER) {
    paint("clearAll");
  }
}

void keyPressed() {
  if (key == 'P' || key == 'p') {
    paused = !paused;
    if (paused) {
      noLoop();
    } else {
      loop();
    }
  }

  //launching rocket
  if (!rocketArray[r].launched && (keyCode == 32 || key == 'z')) {
    rocketArray[r].launched = true;
    //r++; //enable this line to make the cursor automatically move after each launch
    rocketTotal++;
    if (r == J) {
      r = 0;
    }
  }
  //launching all rockets
  if (key == 'x') {
    for (int i = 0; i < rocketArray.length; i++) {
      if (!rocketArray[i].launched) {
        rocketArray[i].launched = true;
        rocketTotal++;
      }
    }
    r = 0;
  }

  //painting rocket
  if (key == 'a' || key == 'A') {
    paint("paint");
  }
  if (key == 's' || key == 'S') {
    paint("paintAll");
  }
  if (key == 'q' || key == 'Q') {
    paint("clear");
  }
  if (key == 'w' || key == 'W') {
    paint("clearAll");
  }

  //choosing rocket
  if (keyCode == LEFT) {
    if (r != 0) {
      r--;
    } else if (r == 0) {
      r = J-1;
    }
  }

  if (keyCode == RIGHT) {
    if (r != J-1) {
      r++;
    } else if (r == J-1) {
      r = 0;
    }
  }
}
