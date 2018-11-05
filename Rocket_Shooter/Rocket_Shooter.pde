/**
 ROCKET SHOOTER
 Matthew Brown, April/May 2018
 ICS4U1
 Sky gradient created by Theo Nguyen
 */

//-- Config
String Player1Name = "Player 1";
String Player2Name = "Player 2";

boolean SMOKES = false; //Will likely cause performance issues
boolean onEARTH = false; //Will probably also cause performance issues due to two rockets with accurate gravity

//-- Drawing
boolean startScreen, mainGame, optionScreen, endScreen; //These are used in draw to determine which screen to display
PImage BGe, BGs; //BGe = background-earth, BGs = background-space
PImage logo;
PFont mainFont;

//-- Constants
float SCALE;
float g;
int smokeTrailLength = 64;

int ARROWS = 0;
int WASD = 1;

// These are used when the rocket dies
int randPick; // Figures out which insult to throw at the loser
int deadRocket; // Keeps track of which rocket died (r[0] or r[1])

//-- Custom-type Object lists
Rocket[] r = new Rocket[2];
Cloud[] cloudList = new Cloud[8];
Shot[] allShots = new Shot[32];
Button startButton, optionButton, optionDoneButton, bgToggle, smokeToggle, restartButton, quitButton;
Textblock options, loseText;

void setup() {
  //size(1200, 1200); // 1200x1200 will make the game run at it's intended scale,
  size(900, 900); // If your monitor can't fit it, pick any square resolution. Speeds don't scale accurately due to their derivative nature.
  SCALE = (width+height)/220*0.1; // Tries it's best to keep sizes constant at different resolutions

  BGe = loadImage("Images/StarlessSkai.png");
  BGs = loadImage("Images/Starfield.png");
  BGe.resize(width, height);
  BGs.resize(width, height);

  logo = loadImage("Images/Rocket Shooter Logo.png");
  logo.resize(int(width*2/3), int(800/2811*logo.height)); // Resize proportionally

  mainFont = createFont("Fonts/VCR_OSD_MONO_1.001.ttf", 32);

  g = 0.1 * SCALE;

  createRockets();

  //-- Buttons
  startButton = new Button(width/2, height/3*2, width/4, height/12, "START GAME");
  optionButton = new Button(width/2, height/3*2 + width/6, width/4, height/12, "OPTIONS");
  bgToggle = new Button(width/3, height/3*2, width/4, height/12, "EARTH/SPACE");
  smokeToggle = new Button(width/3*2, height/3*2, width/4, height/12, "SMOKE TRAILS");
  optionDoneButton = new Button(width/2, height/3*2 + width/6, width/4, height/12, "DONE");
  restartButton = new Button(width/2, height/3*2, width/3, height/12, "RESTART");
  //--

  //-- Plain textblocks
  options = new Textblock("OPTIONS:", width/4/5 * SCALE, width/2, height/5*2.75, true);
  loseText = new Textblock("null", width/4/7.5 * SCALE, width/2, height/3, true);

  //-- Create clouds
  for (int i = 0; i < cloudList.length; i++) {
    cloudList[i] = new Cloud(random(-20*SCALE, width+(20*SCALE)), random(height/5*2, height/5*4), 500*SCALE, 100*SCALE);
    cloudList[i].vel.x = random(-1*SCALE, 1*SCALE);
  }

  //-- Draw screens
  startScreen = true;
  optionScreen = false;
  mainGame = false;
  endScreen = false;
}

void createRockets() {
  //-- Create each Rocket with differing parameters
  r[0] = new Rocket(width/3, height-50*SCALE, 25*SCALE, 50*SCALE, 96*SCALE, WASD, Player1Name);
  r[1] = new Rocket(width/3*2, height-50*SCALE, 25*SCALE, 50*SCALE, 96*SCALE, ARROWS, Player2Name);
  //--
}


//-- Keypresses
// key presses are done with booleans set to true when pressed and set to false when released
// this avoids key-skipping issues and makes movement much smoother.
void keyPressed() {
  for (Rocket r : r) {
    if (keyCode == r.U) {
      r.kUp = true;
    } 
    if (keyCode == r.D) {
      r.kDown = true;
    } 
    if (keyCode == r.L) {
      r.kLeft = true;
    } 
    if (keyCode == r.R) {
      r.kRight = true;
    }
    if (keyCode == r.S) {
      r.kShoot = true;
    }
  }
}

void keyReleased() {
  for (Rocket r : r) {
    if (keyCode == r.U) {
      r.kUp = false;
    } 
    if (keyCode == r.D) {
      r.kDown = false;
    } 
    if (keyCode == r.L) {
      r.kLeft = false;
    } 
    if (keyCode == r.R) {
      r.kRight = false;
    }
    if (keyCode == r.S) {
      r.kShoot = false;
    }
  }
}
//-- end of Keypresses

void draw() {
  //Draw the background every frame
  textFont(mainFont);
  if (onEARTH) image(BGe, 0, 0);
  else image(BGs, 0, 0);

  if (onEARTH) { //Only draw clouds if you're on Earth
    for (Cloud c : cloudList) {
      if (c != null) {
        c.update();
        c.display();
      }
    }
  }

  if (startScreen) { // Show the logo and start & option buttons
    imageMode(CENTER);
    image(logo, width/2, height/3);
    startButton.display();
    optionButton.display();
    imageMode(CORNER);
  }

  if (optionScreen) { // Show the word "Options:" and the two option buttons
    imageMode(CENTER);
    image(logo, width/2, height/3);
    imageMode(CORNER);

    textAlign(CENTER, CENTER);
    options.display();

    if (SMOKES) smokeToggle.FILL = color(230, 128, 128);
    else if (!SMOKES) smokeToggle.FILL = color(128, 230, 128);
    bgToggle.display();
    smokeToggle.display();
    optionDoneButton.display();
  }

  if (mainGame) { // --- MAIN GAME LOOP --- //
    for (Rocket r : r) { // Update each rocket
      if (r != null) {
        if (onEARTH) {
          r.applyForce(new PVector(0, g*r.mass));
        }
        r.update();
        r.display();
      }
    }

    //Rocket shots collisions
    /**
    This works by way of the following:
    On one rocket: 
      Start with one shot (the shots are loaded into an allshots list to allow rocket 0 to check against rocket 1's shots)
        Check if it's the other rocket's shot using the "parent" var of type Rocket that is passed to the shot when it is created
          - Get the (x, y) of each of the 8 points used to check shots
          - Create a list which is the scalar distance between the shot's center and each of the 8 points "shotpoints"
          - Determine the distance between the shot and the closest point
          - Keep track of which spot in the list holds the closest point (var c)
             >> brackets used for clarity in the next line <<
          - If (the distance from the shot to the center of the rocket) is less than (the distance from the "shotpoint" (that is closest to the shot) is from the center:
            - Check If (it's been more than ten frames since it was hit last, for fairness)
              - Hit!!
    */
    
    for (Rocket rocket : r) {
      for (int i = 0; i < allShots.length; i++) {
        if (allShots[i] != null) {
          if (allShots[i].parent != rocket.ID) { //If the shot is from the other rocket
            PVector[] shotPoints = rocket.shotPoints(); // This list holds each of the 8 major vertecies of the rocket 
            
            float[] dists = new float[shotPoints.length];
            for (int j = 0; j < shotPoints.length; j++) {
              dists[j] = dist(shotPoints[j].x, shotPoints[j].y, allShots[i].pos.x, allShots[i].pos.y); // This list holds the distance that the shot is from each of the 8 major points
            }
            
            float closest = min(dists); //Figure out which one the closest one is
            int c = -1;
            for (int j = 0; j < shotPoints.length; j++) {
              if (dists[j] == closest) c = j; //Keep track of the one that's the closest
            }
            
            if (c != -1) { //This was my way of setting an int to null
              // If the shot is closer to the closest of the 8 major points than the center of the rocket is then it's over the rocket
              if (dist(rocket.pos.x, rocket.pos.y, allShots[i].pos.x, allShots[i].pos.y) <= dist(rocket.pos.x, rocket.pos.y, shotPoints[c].x, shotPoints[c].y)) { 
                if (frameCount - rocket.timeLastHit >= 10) {
                  // HIT!! 
                  rocket.health--;
                  rocket.timeLastHit = frameCount;
                  allShots[i] = null;
                  randPick = int(random(0, 3));
                  
                  //Clear the shot
                  if (rocket.ID == r[0].ID) {
                    r[1].shots[i-16] = null;
                  } else if (rocket.ID == r[1].ID) {
                    r[0].shots[i] = null;
                  }
                  
                }
              }
            }
          }
        }
      }
    }

    // Every frame, check if each rocket has zero health
    for (int i = 0; i < r.length; i++) {
      if (r[i].health == 0) {
        mainGame = false;
        endScreen = true;
        deadRocket = i; // Store which rocket died so I can insult them specifically LOL
      }
    }
  }

  if (endScreen) { // Write an insult and display the restart button
    textAlign(CENTER, CENTER);

    if (randPick == 0) {
      loseText.text = r[deadRocket].ID + " got absolutely mullered!";
    } else if (randPick == 1) {
      loseText.text = r[deadRocket].ID + " was destroyed by the better man.";
    } else if (randPick == 2) {
      loseText.text = r[deadRocket].ID + " has died. How tragic.";
    }
    loseText.display();
    restartButton.display();
  }

  fill(0, 255, 0);
  textAlign(RIGHT, TOP);
  textSize(25*SCALE);
  text(int(frameRate), width-5, 5);
}

//-- Mousepressing, does all the logic for the buttons on each screen using a method of the button class
void mousePressed() {
  if (startScreen && startButton.mouseOver()) {
    mainGame = true;
    startScreen = false;
  } else if (startScreen && optionButton.mouseOver()) {
    startScreen = false;
    optionScreen = true;
  } else if (optionScreen && bgToggle.mouseOver()) {
    onEARTH = !onEARTH;
  } else if (optionScreen && smokeToggle.mouseOver()) {
    SMOKES = !SMOKES;
  } else if (optionScreen && optionDoneButton.mouseOver()) {
    optionScreen = false;
    startScreen = true;
  } else if (endScreen && restartButton.mouseOver()) {
    endScreen = false;
    startScreen = true;
    createRockets(); //Remake the rockets when you click reset.
    //This means (since it creates entirely new (but identical) rockets) I don't have to
    //change all the inner variables back to how they were before
  }
}
