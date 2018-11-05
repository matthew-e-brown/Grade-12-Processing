void setup() {
  size(750, 500);
  background(10);
}

int pressedKeyCode, pressedMouseCode;
String pressedKey;
boolean mPressTF;

void draw() {
  background(g.backgroundColor);
  colorMode(HSB, 360, 100, 100);
  textSize(20);
  fill(floor(map(pressedKeyCode, 65, 122, 0, 360)), 100, 100);
  if (pressedKey != "null" &&  mPressTF != true) {
    text("You pressed \"" + pressedKey + "\", which has the keycode: " + str(pressedKeyCode), mouseX, mouseY);
  } else if (pressedKey == "null" && mPressTF != true) {
    text("Non letter key, with keycode: " + pressedKeyCode, mouseX, mouseY);
  }
  else if (mPressTF){
    text("You pressed \"" + pressedKey + "\", which has the keycode: " + str(pressedMouseCode), mouseX, mouseY);
  }
  rect(mouseX, mouseY+30, map(pressedKeyCode, 65, 122, 0, 435), 10);
  colorMode(RGB);
}

void mouseClicked() {
  //println("Mouse Button: " + mouseButton);
  if (mouseButton == LEFT){ //these if statements basically make it so that the color will become a random color in the first, second, or third third of the spectrum. 
    pressedKeyCode = int(floor(random(65, 84)));
    pressedKey = "L. mButton";
    mPressTF = true;
    pressedMouseCode = mouseButton;
  }
  else if (mouseButton == CENTER){
    pressedKeyCode = int(floor(random(84, 103)));
    pressedKey = "MID. mButton";
    mPressTF = true;
    pressedMouseCode = mouseButton;
  }
  else if (mouseButton == RIGHT){
    pressedKeyCode = int(floor(random(103,122)));
    pressedKey = "R. mButton";
    mPressTF = true;
    pressedMouseCode = mouseButton;
  }
}

void keyPressed() {
  mPressTF = false;
  //println("Key Code: " + keyCode + "\t\tKey: " + key);
  if (keyCode >= 32 && keyCode <= 127) { //every numerical key
    pressedKeyCode = keyCode;
    pressedKey = str(key);
    if (pressedKey == pressedKey.toLowerCase() && key != CODED) {//checks if the key was lower case
      pressedKeyCode += 32; //changes the ascii code to the lowercase one
      //pressedKey = pressedKey.toUpperCase(); //changes key to upper case
    } else if (key == CODED) {
      pressedKey = "null";
    }
  }
}