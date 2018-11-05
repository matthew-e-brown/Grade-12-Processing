int MAXSPOTS = 100;
Spot spotList[] = new Spot[MAXSPOTS];
float spotWidth;
float SCALE;
int s; //where in the list are you

void setup() {
  size(1000, 1000);
  SCALE = (width+height)/1000;
  spotWidth = width/10;

  for (int i = 1; i <= int(MAXSPOTS/10); i++) {
    spotList[i] = new Spot((i-1)*spotWidth+(0.5*spotWidth), width/2, 0, random(-5, 5)*SCALE);
    s = i;
    spotList[i].FILL = color(255, 100, 100, 100);
  }
  println(s);
}

void draw() {
  background(0);
  for (int i = 0; i < MAXSPOTS-1; i++) {
    if (spotList[i] != null) {
      spotList[i].display();
      spotList[i].move();
    }
  }
}

void mousePressed() {
  
}
