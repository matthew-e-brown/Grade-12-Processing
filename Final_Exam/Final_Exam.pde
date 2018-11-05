Orb[] orbs;

void setup() {
  size(600, 600);
  orbs = new Orb[100];

  colorMode(HSB, 360, 100, 100);

  createOrbs();
}

void draw() {
  background(210);

  for (Orb orb : orbs) {
    orb.display();
  }
  
  textSize(24);
  fill(0);
  text("Press Enter for new orbs", 27, 27);
  fill(0, 0, 100);
  text("Press Enter for new orbs", 25, 25);
}

public void createOrbs() {
  for (int i = 0; i < orbs.length; i++) { //Creating orbs
    boolean flag = true; //While flag == true, the loop below will keep picking and checking new orbs
    float randr = 0, randx = 0, randy = 0;
    while (flag == true) {
      randr = random(2.5, 50);
      randx = random(0+randr, width-randr); //The adition of the radius here means that they won't go off the end of the screen
      randy = random(0+randr, width-randr);
      if (nullcounter(orbs) < orbs.length) { //If there's at least one non-null orb
        int fits = 0; //Counts how many of the current orbs that the new orb fits around
        for (int o = 0; o < orbs.length - nullcounter(orbs); o++) { //For all non-null orbs in the list
          if (dist(orbs[o].x, orbs[o].y, randx, randy) > (randr + orbs[o].r)*1.15) fits++;
        }           
        if (fits == orbs.length - nullcounter(orbs)) { //If all of the non-null orbs fit
          flag = false; //Set the loop condition equal to false; exit the parent while loop.
        } else flag = true;
      } else if (nullcounter(orbs) == orbs.length) { //If all the orbs are null; if this is the first orb
        flag = false; //Skip checking, since there's nothing to check
      }
    } //End of while loop: this point will only be reached once the chosen random values fit into the current array of circles

    color randfill = color(random(0, 360), random(65, 100), random(65, 100)); //fill has no need to be checked, so it's outside the while loop
    color randstroke = color(random(0, 360), random(65, 100), random(65, 100)); //Stroke doesn't either

    orbs[i] = new Orb(randx, randy, randr, randfill, randstroke); //Now that we know that it fits and we've picked colors, we can create the orb.
  } //End of creating orbs
}

void keyPressed() {
  if (keyCode == 10 || keyCode == 13) {
    println("Generating new orbs...");
    createOrbs();
  }
}

class Orb {
  float x, y, r;
  color fill, stroke;
  Orb(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  Orb(float x, float y, float r, color fill, color stroke) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.fill = fill;
    this.stroke = stroke;
  }

  void display() {
    ellipseMode(CENTER);
    fill(fill);
    strokeWeight(2);
    stroke(stroke);

    ellipse(x, y, r*2, r*2);
  }
}

int nullcounter(Orb[] list) {
  int nulls = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i] == null) nulls++;
  }
  return nulls;
}
