PImage BG;
PFont mainFont;
float SCALE, beanRadius;
Bird pyoro;
boolean keyleft, keyright, paused;

int L = 0;
int R = 1;

Block[] blockList = new Block[30];

Bean[] beanList = new Bean[256];
int b = 0; //Which spot in the list of beans are you at?

Scoreblip[] blipList = new Scoreblip[beanList.length];

{
  keyleft = false;
  keyright = false;
  paused = false;
}

int score = 0;

TextBlock pausedText, scoreText;

void setup() {
  //size(1500, 1125); // use a 4:3 aspect ratio (original ran at 256x192)
  size(600, 450);
  frameRate(60);

  BG = loadImage("Sprites/Background.png");
  BG.resize(width, height);

  mainFont = createFont("Fonts/VCR_OSD_MONO_1.001.ttf", 32);
  textFont(mainFont);

  SCALE = ((width+height)/225)*0.05;
  //println(SCALE);

  pyoro = new Bird();

  for (int i = 0; i < 30; i++) {
    blockList[i] = new Block(i*(width/30), height-(width/30), i);
  }

  scoreText = new TextBlock("null", 80*SCALE, width/5, 0 + 5*SCALE, true);
  pausedText = new TextBlock("PAUSED", 160*SCALE, width/2, height/2, true);
}

void draw() { 
  scoreText.text = "Score: " + score;

  background(BG);
  if (frameRate < 50 && frameCount > 480) println(millis()/1000 + " Seconds into sim: Low FPS! " + frameRate);

  if (!paused) { //Only update everything if the game isn't paused...
    pyoro.update();

    for (Bean bean : beanList) { //Check if Pyoro is hit
      if (bean != null) {
        if (birdCollide(pyoro, bean)) {
          //pyoro is hit!
        }
      }
    }

    for (Bean bean : beanList) { //Check if a block was hit
      boolean nullify = false;
      if (bean != null) {
        for (Block block : blockList) {
          if (block.alive && blockCollide(block, bean)) {
            block.hit = true;
            nullify = true;
          }
        }
      }
      if (nullify) bean = null;
    }

    for (int i = 0; i < beanList.length; i++) { //Update the position of the beans
      if (beanList[i] != null) {
        beanList[i].update();
        if (beanList[i].position.y > height+beanRadius*2) {
          beanList[i] = null;
        }
      }
    }

    for (int i = 0; i < blipList.length; i++) { //Update the position of the scoreblips
      if (blipList[i] != null) {
        blipList[i].update();
        if (blipList[i].framesActive >= 105) {
          blipList[i] = null;
        }
      }
    }
  }

  // But still draw it! Then put a transparent rectangle over it to grey it out
  pyoro.display();

  for (int i = 0; i < 30; i++) {
    blockList[i].update();
    blockList[i].display();
  }

  for (int i = 0; i < beanList.length; i++) {
    if (beanList[i] != null) {
      beanList[i].display();
    }
  }

  for (int i = 0; i < blipList.length; i++) {
    if (blipList[i] != null) {
      blipList[i].display();
    }
  }

  textAlign(LEFT, TOP);
  scoreText.display();

  if (paused) {
    noStroke();
    fill(10, 10, 10, 128);
    rect(0, 0, width, height);

    textAlign(CENTER, CENTER);
    pausedText.display();
  }
}

boolean birdCollide(Bird bird, Bean bean) {
  boolean wid, hei;
  if (bean.position.x+beanRadius >= bird.x && bean.position.x - beanRadius <= bird.x+bird.w) wid = true;
  else wid = false;

  if (bean.position.y + 2*beanRadius >= bird.y && bean.position.y <= bird.y+bird.h) hei = true;
  else hei = false;

  if (wid && hei) return true;
  else return false;
}

boolean blockCollide(Block block, Bean bean) {
  boolean wid, hei;
  wid = false;
  hei = false;

  if (bean.position.x >= block.pos.x && bean.position.x <= block.pos.x + block.BLOCK.width) wid = true;
  if (bean.position.y + beanRadius >= block.pos.y) hei = true;

  if (wid && hei) return true;
  else return false;
}
