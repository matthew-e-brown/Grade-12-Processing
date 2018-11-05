boolean zUp = true; //This makes it so they can't hold down the button to fire a ton at once

//Mouse is used for debugging. Left click Teleports Pyoro. Right click restores blocks. Middle restores all.
void mousePressed() {
  if (mouseButton == LEFT) {
    pyoro.x = mouseX;
  } if (mouseButton == RIGHT) {
    for (int i = 0; i < blockList.length; i++) {
      if (mouseX >= blockList[i].pos.x && mouseX <= blockList[i].pos.x + width/30 && mouseY >= height-width/30) {
        blockList[i].alive = true;
        blockList[i].pos.y = height-width/30;
      }
    }
  } if (mouseButton == CENTER) {
    for (int i = 0; i < blockList.length; i++) {
      blockList[i].alive = true;
      blockList[i].pos.y = height-width/30;
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keyleft = true;
    } 
    if (keyCode == RIGHT) {
      keyright = true;
    }
  } else if (key != CODED) {
    if (key == 'z' || key == 'Z') {
      if (zUp) pyoro.spit();
      zUp = false;
    }
    if (key == 'p' || key == 'P') {
      paused = !paused;
    }
    if (key == 'b' || key == 'B') {      
      beanList[b] = new Bean(random(0, width), -1 * beanRadius*2, random(1.75*SCALE, 2.75*SCALE), "Bean");
      
      if (b < 255) {
        b++;
      } else {
        b = 0;
      }
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keyleft = false;
    } 
    if (keyCode == RIGHT) {
      keyright = false;
    }
  } else if (key != CODED) {
    if (key == 'z' || key == 'Z') {
      zUp = true;
    }
  }
}
