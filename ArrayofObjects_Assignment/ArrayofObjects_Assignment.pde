int MAXLINES = 50; // This changes how many lines are allowed on the screen at once.
int s = 0; // This is the variable that keeps track of where in the array the user is.
float SCALE; // This variable is chosen to be roughly equal to what 1 "pixel" would be at a normal resolution. This is defined in setup.
color BG = color(0, 0, 0, 255);
boolean PAUSED = false;
int time; // Keeps track of how much time has passed since the last rectangle has been placed.

Line[] lines = new Line[MAXLINES];

void setup() {
  size(1920, 1080);
  //fullScreen();
  SCALE = (width+height)/600; // This is the var. that everything is proportional to.
  frameRate(60);
  time = millis();
}

void draw() {
  background(BG);
  
  // Updates and draws all of the lines.
  for (int i = 0; i < lines.length; i++) {
    if (lines[i] != null) {
      lines[i].update();
      lines[i].display();
    }
  }

  // Draws the FPS. Was for debugging/
  /*
  fill(255);
  textAlign(RIGHT, TOP);
  textSize(SCALE*10);
  text("FPS: " + floor(frameRate), width-SCALE*3, SCALE*3);
  */

  // Makes a new rectangle every ~1000 milliseconds
  if (millis() - time >= 1000) {
    time = millis();

    // Changes what position in the array is 'selected.' 
    // This also handles resetting when the max amount is met.
    if (s < MAXLINES-1) {
      s++;
    } else {
      s = 0;
    }
    
    // Instantiates the new line.
    lines[s] = new Line(random(0, width), random(0, height), SCALE*3.69420, SCALE*25, floor(random(-2, 2.1)), SCALE*random(1, 4)); // X, Y, Width, Length, Direction, Speed
  }
}

void keyPressed() {
  // Fairly simple. Just for pausing.
  if (key == 'P' || key == 'p') {
    PAUSED = !PAUSED;
    if (PAUSED) {
      noLoop();
    } else if (!PAUSED) {
      loop();
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    // Checks if the user has clicked ON the rectangle when they click.
    for (int i = 0; i < lines.length; i++) {
      if (lines[i] != null) {
        if (lines[i].mouseOver) {
          lines[i].clicked = !lines[i].clicked;
        }
      }
    }
  }
}
