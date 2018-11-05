class Rocket extends Object {
  int TIMETOSHOOT = 10; //How many frames must pass before the rocket can shoot again
  PVector thrust; //Starts as null but is calculated with trig every frame based on the rotation of the rocket
  float thrustSpeed; //Magnitude of the thrust

  SmokeBlob[] smokes = new SmokeBlob[smokeTrailLength]; //Each rocket has it's own smoke trail
  int s; //s keeps track of where in the list of smokes you are
  int b; //b (for boom) keeps track of where in the shotlist you are

  // Used to limit the time the rockets can be hit or shoot
  int timeLastShot = 0;
  int timeLastHit = 0;

  // These are used to map Up, Down, Left, Right, to UDLR or WSAD based on the "keySet" constructor variable
  boolean kLeft, kRight, kDown, kUp, kShoot;
  int L, R, U, D, S;

  color ACCENT = color(0); // The colour of the rocket nose and fins and shot

  Shot[] shots = new Shot[16];
  int shotSection = 0; //Player 1 = section 0 of the main allShots list used for collision

  String ID; // Used for comparison elsewhere in the program (more reliable than r[0] or r[1] in some cases)

  int health;
  PImage heart, eHeart; //eHeart = empty heart

  Rocket(float x, float y, float w, float h, float thrustSpeed, int keySet, String ID) {
    super(x, y, w, h); //Make an Object with x, y, w, h
    this.ID = ID;
    p = 0.5; //p = rho, density
    mass = w*h*p; //mass = volume (although area is used b/c 2D) times density
    this.thrustSpeed = thrustSpeed;

    thrust = new PVector(0, 0);
    drag = new PVector(0, 0);
    s = 0;

    if (ID == Player1Name) { //Sets two different colour and heart colour depending on what player is playing
      ACCENT = color(255, 50, 50);
      heart = loadImage("Images/Red-Heart.png");
    } else if (ID == Player2Name) {
      ACCENT = color(50, 200, 50);
      heart = loadImage("Images/Green-Heart.png");
    }      
    eHeart = loadImage("Images/Empty-Heart.png");
    heart.resize(int(width*0.02), int(height*0.02));
    eHeart.resize(int(width*0.02), int(height*0.02));

    if (keySet == WASD) { //Matches the keys the rocket takes for up down left and right based on the constructor
      U = 87;
      D = 83;
      L = 65;
      R = 68;
      S = 32;
      shotSection = 0;
    } else if (keySet == ARROWS) {
      U = 38;
      D = 40;
      L = 37;
      R = 39;
      S = 92;
      shotSection = 1;
    }

    health = 3;
  }

  void shoot(Rocket ID) { //Creates a new Shot object and gives it a push in the direction the rocket is facing
    if (b >= shots.length) b = 0;
    shots[b] = new Shot(ID);
    shots[b].applyForce(new PVector(18*thrustSpeed * cos(radians(90-angle)), -18*thrustSpeed * sin(radians(90-angle))));
    b++;
  }

  void update() { //Where all the magic happens!
    edges(); //The rocket has a special edges method (explained below)
    super.update(); //Does the pos.vel.acc stuff

    //Rotate the bro
    if (kLeft) angle -= 2.5;
    if (kRight) angle += 2.5;

    if (kUp) {
      //Calculate Thrust
      thrust.x = thrustSpeed * cos(radians(90-angle));
      thrust.y = -thrustSpeed * sin(radians(90-angle));
      applyForce(thrust);

      //Create a smoke trail
      if (SMOKES) {
        if (s >= smokes.length) s = 0;
        smokes[s] = new SmokeBlob(getRocketTail().x, getRocketTail().y, w*0.9, w*0.9);
        PVector smokeLaunch = thrust.copy();
        smokeLaunch.mult(-0.25*SCALE);
        smokes[s].applyForce(smokeLaunch);
        s++;
      }
    }

    //Calculate and apply drag on the rocket
    float mu = ((w+h)*p)/20; //Just base the coefficient of friction on surface area and made up density
    drag = calculateDrag(vel, mu);
    applyForce(drag);

    //Update each of the rocket's smokeblobs
    for (int i = 0; i < smokes.length; i++) {
      if (smokes[i] != null) {
        //Apply drag on the smokes
        float smu = smokes[i].mass/20; 
        smokes[i].drag = calculateDrag(smokes[i].vel, smu);
        smokes[i].applyForce(smokes[i].drag);
        smokes[i].update();
        if (smokes[i].timeAlive >= smokeTrailLength) smokes[i] = null; //Kill them after a while
      }
    }

    if (timeAlive - timeLastShot >= TIMETOSHOOT && kShoot) { //This if statement makes it so they can inly shoot every so often (defined uptop)
      shoot(this);
      timeLastShot = timeAlive;
    }

    //Update all of each of the rocket's shots
    for (int i = 0; i < shots.length; i++) {
      if (shots[i] != null) {
        shots[i].update();
        if (shots[i].timeAlive > 60) {
          shots[i] = null;
        }
      }
    }

    //Every frame, each rocket, based on which player it is, dumps their shots into a list of all shots
    //Player one's shots are the first 16 (0 to 15) of the array, and 2's are 16-31. That way I can compare each rocket against all the shots.
    if (shotSection == 0) {
      for (int i = 0; i < shots.length; i++) {
        allShots[i] = shots[i];
      }
    } else if (shotSection == 1) {
      for (int i = 0; i < shots.length; i++) {
        allShots[16+i] = shots[i];
      }
    }
  }

  void edges() {
    //Redefining the parent method, since the rocket's rotation creates a more complex problem to solve
    //Instead of checking the centre of the rocket, it would make more sense to check only the piece 
    //that is closest to the edge in question
    float highest, lowest, leftmost, rightmost;

    //Checks what the highest and lowest points are
    float[] allY = new float[bumpPoints().length];
    for (int i = 0; i < bumpPoints().length; i++) allY[i] = bumpPoints()[i].y;
    highest = min(allY);
    lowest = max(allY);

    //Checks what the left and rightmost parts are
    float[] allX = new float[bumpPoints().length];
    for (int i = 0; i < bumpPoints().length; i++) allX[i] = bumpPoints()[i].x;
    leftmost = min(allX);
    rightmost = max(allX);

    //Then it does the regular edges function but using highest on the top of the screen, etc.
    if (highest <= 0) {
      pos.y = 0 + dist(pos.x, pos.y, pos.x, highest);
      vel.y *= -0.75;
    }
    if (lowest >= height) {
      pos.y = height - dist(pos.x, pos.y, pos.x, lowest);
      vel.y *= -0.75;
    }
    if (rightmost < 0) {
      //pos.x = 0 + dist(pos.x, pos.y, leftmost, pos.y);
      //vel.x *= -0.75;
      pos.x = width + dist(pos.x, pos.y, rightmost, pos.y);
    }
    if (leftmost > width) {
      //pos.x = width - dist(pos.x, pos.y, rightmost, pos.y);
      //vel.x *= -0.75;
      pos.x = 0 - dist(pos.x, pos.y, leftmost, pos.y);
    }
  }

  void display() {
    for (SmokeBlob smoke : smokes) {
      if (smoke != null) {
        smoke.display();
      }
    }

    for (Shot s : shots) {
      if (s != null) {
        s.display();
      }
    }

    imageMode(CENTER);
    if (health == 3) {
      for (int i = 0; i < 3; i++) {
        image(heart, pos.x - w*1.25 + w*1.25*i, pos.y - h*1.5);
      }
    } else if (health == 2) {
      for (int i = 0; i < 2; i++) {
        image(heart, pos.x - w*1.25 + w*1.25*i, pos.y - h*1.5);
      }
      image(eHeart, pos.x - w*1.25 + w*1.25*2, pos.y - h*1.5);
    } else if (health == 1) {
      image(heart, pos.x - w*1.25, pos.y - h*1.5);
      for (int i = 1; i < 3; i++) {
        image(eHeart, pos.x -w*1.25 + w*1.25*i, pos.y - h*1.5);
      }
    }
    imageMode(CORNER);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));
    {
      //Draw the Rocket

      fill(255);
      stroke(0);
      rectMode(CENTER);
      rect(0, 0, w, h); //Fuselage

      fill(ACCENT);
      ellipse(0, 0, 8*SCALE, 8*SCALE); //Window
      triangle(0-0.5*w, -0.5*h, 0, 0-h, 0+0.5*w, -0.5*h); //Nose: Left, Tip, Right
      triangle(0-0.5*w, 0+0.1*h, 0-0.5*w, 0+0.5*h, 0-w, 0+0.5*h); //Left Fin: Top, Bottom, Tip
      triangle(0+0.5*w, 0+0.1*h, 0+0.5*w, 0+0.5*h, 0+w, 0+0.5*h); //Right Fin: Top, Bottom, Tip

      //imageMode(CENTER);
      //image(XWing, 0, -80*SCALE);
      //imageMode(CORNER);

      if (kUp) {
        float flameLength = random(1.4*thrustSpeed*0.25, 1.4*thrustSpeed*0.5);
        noStroke();
        fill(#FF2D03);
        triangle(0, 0+(0.5*h)+(flameLength), 0-0.5*w, 0+0.5*h, 0+0.5*w, 0+0.5*h); //Outer Flame
        fill(#FF9305);
        triangle(0, 0+(0.5*h)+(flameLength*2/3), 0-0.5*w, 0+0.5*h, 0+0.5*w, 0+0.5*h); //Middle Flame
        fill(#FFFF80); 
        triangle(0, 0+(0.5*h)+(flameLength*1/3), 0-0.5*w, 0+0.5*h, 0+0.5*w, 0+0.5*h); //Inner Flame
      }
    }
    popMatrix();

    //--Enabling this block will draw a dot at each of the points used for collisions
    fill(255, 255, 128);
    stroke(0);
    for (int i = 0; i < bumpPoints().length; i++) {
      ellipse(bumpPoints()[i].x, bumpPoints()[i].y, 8*SCALE, 8*SCALE);
    }
  }

  //--- Collision Detection Points ---//
  PVector[] bumpPoints() { //Every point used for the collision with the edges
    PVector[] points = new PVector[5];
    points[0] = getRocketNose();
    points[1] = getRocketTopLeft();
    points[2] = getRocketTopRight();
    points[3] = getRocketLeftFinTip();
    points[4] = getRocketRightFinTip();
    return points;
  }

  PVector[] shotPoints() { //Every point used to check proximity to bullets
    PVector[] points = new PVector[8];
    points[0] = getRocketNose();
    points[1] = getRocketTopLeft();
    points[2] = getRocketTopRight();
    points[3] = getRocketLeft();
    points[4] = getRocketRight();
    points[5] = getRocketLeftFinTip();
    points[6] = getRocketTail();
    points[7] = getRocketRightFinTip();
    return points;
  }

  // Each of these "getRocket[position]" methods was trial and error using Trig to find the right distances from the center.
  PVector getRocketTail() {
    float hyp = 0.5*h;
    float x = hyp*sin(radians(-angle));
    float y = hyp*cos(radians(angle));
    return new PVector(pos.x+x, pos.y+y);
  }

  PVector getRocketNose() {
    float hyp = h;
    float x = hyp*sin(radians(-angle));
    float y = hyp*cos(radians(-angle));
    return new PVector(pos.x-x, pos.y-y);
  }

  PVector getRocketRight() {
    float hyp = 0.5*w;
    float x = hyp*cos(radians(angle));
    float y = hyp*sin(radians(angle));
    return new PVector(pos.x+x, pos.y+y);
  }

  PVector getRocketLeft() {
    float hyp = -0.5*w;
    float x = hyp*cos(radians(angle));
    float y = hyp*sin(radians(angle));
    return new PVector (pos.x+x, pos.y+y);
  }

  PVector getRocketTopLeft() {
    float hyp = 0.5*h;
    float x = hyp*sin(radians(-angle));
    float y = hyp*cos(radians(-angle));
    return new PVector(getRocketLeft().x - x, getRocketLeft().y - y);
  }

  PVector getRocketTopRight() {
    float hyp = 0.5*h;
    float x = hyp*sin(radians(angle));
    float y = hyp*cos(radians(angle));
    return new PVector(getRocketRight().x + x, getRocketRight().y - y);
  }

  PVector getRocketLeftFinTip() {
    float hyp = w;
    float x = hyp*cos(radians(-angle));
    float y = hyp*sin(radians(angle));
    PVector above = new PVector(pos.x - x, pos.y - y);

    hyp = 0.5*h;
    x = hyp*sin(radians(-angle));
    y = hyp*cos(radians(angle));
    return new PVector(above.x + x, above.y + y);
  }

  PVector getRocketRightFinTip() {
    float hyp = w;
    float x = hyp*cos(radians(-angle));
    float y = hyp*sin(radians(angle));
    PVector above = new PVector(pos.x + x, pos.y + y);

    hyp = 0.5*h;
    x = hyp*sin(radians(-angle));
    y = hyp*cos(radians(angle));
    return new PVector(above.x + x, above.y + y);
  }

  //--- End of Collision Detection Points ---//
}
