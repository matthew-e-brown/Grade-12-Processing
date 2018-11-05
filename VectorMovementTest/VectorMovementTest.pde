PVector g, wind;
float SCALE; 

boolean mouseLeft, mouseRight;

Object[] objects = new Object[50];

void setup() {
  size(1920, 1080);
  SCALE = (width+height)/220*0.1;
  g = new PVector(0, 0.1);
  wind = new PVector(0.5, 0);

  for (int i = 0; i < objects.length; i++) {
    objects[i] = new Object(random(width), random(height), 50*SCALE, 50*SCALE);
  }

  mouseLeft = false;
  mouseRight = false;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    mouseLeft = true;
  }
  if (mouseButton == RIGHT) {
    mouseRight = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    mouseLeft = false;
  }
  if (mouseButton == RIGHT) {
    mouseRight = false;
  }
}

void draw() {
  background(200);

  for (Object obj : objects) {
    PVector Fg = new PVector(0, g.y*obj.mass);
    obj.applyForce(Fg);
    if (mouseLeft) obj.applyForce(wind);
    obj.update();
    obj.display();
  }
}
