void setup() {
  size(600,600);
  frameRate(60);
}

class Car {
  color c;
  float xpos;
  float ypos;
  float xspeed;
  
  Car() {
    c = color(255);
    xpos = width/2;
    ypos = height/2;
    xspeed = 1;
  }
  
  void draw() {
    background(0);
    display();
    drive();
  }
  
  void display() {
    rectMode(CENTER);
    fill(c);
    rect(xpos, ypos, 20, 10);
  }
  
  void drive() {
    xpos += xspeed;
    if (xpos > width) {
      xpos = 0;
    }
  }
}

Car myCar = new Car();

void draw() {
  background(255);
  myCar.drive();
  myCar.display();
}