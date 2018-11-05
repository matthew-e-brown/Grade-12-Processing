class Bird {
  PImage STANDARDL, STANDARDR;
  PImage STANDARDLdown, STANDARDRdown;
  PImage SPITTINGL, SPITTINGR;
  float x, y, w, h;

  int SPEED = int(10*SCALE);

  int dir; // 0 is left, 1 is right

  PVector shot, shotEnd, add;

  boolean spitting = false;
  boolean down = false;

  int spitTime; // frame at which seed button was pressed

  int maxDeb = 128;
  Debris[] debrisList = new Debris[maxDeb];
  int deb = 0;

  Bird() {

    // Standard Sprites
    STANDARDL = loadImage("Sprites/Pyoro Standard Sprite L.png");
    STANDARDR = loadImage("Sprites/Pyoro Standard Sprite R.png");
    STANDARDL.resize(int(STANDARDL.width*SCALE), int(STANDARDL.height*SCALE));
    STANDARDR.resize(int(STANDARDR.width*SCALE), int(STANDARDR.height*SCALE));

    // Standard Sprites (down) //this is because he bobs when walking
    STANDARDLdown = loadImage("Sprites/Pyoro Standard Sprite LD.png");
    STANDARDRdown = loadImage("Sprites/Pyoro Standard Sprite RD.png");
    STANDARDLdown.resize(int(STANDARDLdown.width*SCALE), int(STANDARDLdown.height*SCALE));
    STANDARDRdown.resize(int(STANDARDRdown.width*SCALE), int(STANDARDRdown.height*SCALE));

    // Spitting Sprites
    SPITTINGL = loadImage("Sprites/Pyoro Spitting Sprite L.png");
    SPITTINGR = loadImage("Sprites/Pyoro Spitting Sprite R.png");
    SPITTINGL.resize(int(SPITTINGL.width*SCALE), int(SPITTINGL.height*SCALE));
    SPITTINGR.resize(int(SPITTINGR.width*SCALE), int(SPITTINGR.height*SCALE));

    x = width/2;
    y = height-STANDARDL.height-int(width/30);
    w = STANDARDL.width;
    h = STANDARDL.height;

    dir = L;
  }

  void spit() {
    spitTime = frameCount;
    spitting = true;

    if (dir == L) {
      debrisList[deb] = new Debris(x - STANDARDL.width*0.25, y - STANDARDL.width*0.1, -6*SCALE, -10*SCALE);
      debrisList[deb+1] = new Debris(x - STANDARDL.width*0.25, y - STANDARDL.width*0.1, -0.5*SCALE, -10*SCALE);
    } else if (dir == R) {
      debrisList[deb] = new Debris(x + STANDARDR.width + STANDARDR.width*0.1, y - STANDARDL.width*0.1, 6*SCALE, -10*SCALE);
      debrisList[deb+1] = new Debris(x + STANDARDR.width + STANDARDR.width*0.1, y - STANDARDL.width*0.1, 0.5*SCALE, -10*SCALE);
    }
    if (deb+2 < maxDeb) deb += 2;
    else deb = 0;

    int beansAtOnce = 0;
    int scorePerBean = 0;

    boolean[] beansHit = new boolean[beanList.length];
    for (int i = 0; i < beanList.length; i++) {
      beansHit[i] = false;
    }

    for (int i = 0; i < beanList.length; i++) {
      if (beanList[i] != null) {
        if (shoot(beanList[i])) {
          beansHit[i] = true;
          beansAtOnce++;
        }
      }
    }

    score += 50 * pow(beansAtOnce, 2); //If you hit 2 beans, you get 100 per bean (50 * 2 * 2) = (50 * 2^2);
    scorePerBean = 50 * beansAtOnce;

    for (int i = 0; i < beansHit.length; i++) {
      if (beansHit[i]) {
        blipList[i] = new Scoreblip(beanList[i].position.x, beanList[i].position.y, scorePerBean);
        beanList[i] = null;
      }
    }
  }

  void update() {
    int[] nearestDeadBlocks = new int[2];
    nearestDeadBlocks = checkBlocks(dir);

    if (keyleft) dir = L;
    else if (keyright) dir = R;

    if (!spitting) {
      if (keyleft) {
        if (x >= 0) x -= SPEED; //move the bird
        if (frameCount % 3 == 0) {
          down = !down;
        }
      } else if (keyright) {
        if (x <= width-w) x += SPEED; //move the bird
        if (frameCount % 3 == 0) {
          down = !down;
        }
      } else if (!keyleft && !keyleft) {
        down = false;
      }
    }
    if (frameCount - spitTime >= 10) {
      spitting = false;
    }

    if (nearestDeadBlocks[L] == -1 && nearestDeadBlocks[R] == 30) { //If there isn't one dead either side
      x = constrain(x, 0, width - w);
    } else if (nearestDeadBlocks[L] == -1 && nearestDeadBlocks[R] != 30) {//If there isn't one dead Left
      x = constrain(x, 0, blockList[nearestDeadBlocks[R]].pos.x + width/30);
    } else if (nearestDeadBlocks[L] != -1 && nearestDeadBlocks[R] == 30) { //If there isn't one dead Right
      x = constrain(x, blockList[nearestDeadBlocks[L]].pos.x + width/30, width - STANDARDL.width);
    } else {
      x = constrain(x, blockList[nearestDeadBlocks[0]].pos.x + width/30, blockList[nearestDeadBlocks[1]].pos.x - w);
    }
  }

  void display() { 
    if (!spitting) {
      if (dir == L) {
        if (!down) image(STANDARDL, x, y); 
        else if (down) image(STANDARDLdown, x, y);
      } else if (dir == R) {
        if (!down) image(STANDARDR, x, y);
        else if (down) image (STANDARDRdown, x, y);
      }
    } else if (spitting) {
      if (dir == L) {
        image(SPITTINGL, x-(0.25*STANDARDL.width), y-(0.25*STANDARDL.width));
      } else if (dir == R) {
        image(SPITTINGR, x, y-(0.25*STANDARDL.width));
      }
    }
    for (int i = 0; i < debrisList.length; i++) {
      if (debrisList[i] != null) {
        debrisList[i].update();
        debrisList[i].display();
      }
    }
  }

  boolean shoot(Bean target) {
    if (dir == L) {
      shot = new PVector(x, y);
      shotEnd = new PVector(x, y);
      add = new PVector(-1, -1);
    } else if (dir == R) {
      shot = new PVector(x + STANDARDL.width, y);
      shotEnd = new PVector(x + STANDARDL.width, y);
      add = new PVector(1, -1);
    }

    while (shotEnd.y > 0) {
      shotEnd.add(add);
    }

    float m = (shotEnd.y - shot.y) / (shotEnd.x - shot.x);
    float b = -1*(m*shot.x) + shot.y;

    float shotYatTargetX = m * (target.position.x) + b;

    float tolerance = beanRadius*1.5;

    //This is easier to read than having one long if statement that returns true
    boolean top, bottom, aboveBird;
    if (shotYatTargetX >= target.position.y - tolerance*0.75) top = true; 
    else top = false;
    if (shotYatTargetX <= target.position.y + beanRadius*2 + tolerance) bottom = true; 
    else bottom = false;
    if (target.position.y < y+STANDARDL.height*0.125) aboveBird = true; 
    else aboveBird = false;

    if (top && bottom && aboveBird) {
      return true;
    } else {
      return false;
    }
  }

  int[] nearestDeads = new int[2];

  int[] checkBlocks(int dirFacing) {
    int nearestDeadBlockL = -1;
    int nearestDeadBlockR = 30;
    //Logic to constrain x to between the nearest dead blocks
    //x+STANDARDL.width*0.25 (4/16 pixels)
    boolean[] blocksAlive = new boolean[blockList.length];
    for (int i = 0; i < blockList.length; i++) {
      blocksAlive[i] = blockList[i].alive;
    }

    int blockOver = 0;
    //Find which block his left foot is over
    //Go through a for loop for each of these variables
    float xPos = width/2;
    for (int i = 0; i < blockList.length; i++) {
      if (dirFacing == L) xPos = x + w*0.25 + 10*SCALE;
      else if (dirFacing == R) xPos = x + w*0.6875 - 10*SCALE;

      if (xPos >= blockList[i].pos.x && xPos <= blockList[i].pos.x + width/30) {
        blockOver = i;
      }
    }
    for (int i = blockOver; i >= 0; i--) {
      if (!blocksAlive[i]) {
        nearestDeadBlockL = i;
        break;
      }
    }
    for (int i = blockOver; i < blockList.length; i++) {
      if (!blocksAlive[i]) {
        nearestDeadBlockR = i;
        break;
      }
    }

    int[] LaR = new int[2];
    LaR[0] = nearestDeadBlockL;
    LaR[1] = nearestDeadBlockR;
    return LaR;
  }
}
