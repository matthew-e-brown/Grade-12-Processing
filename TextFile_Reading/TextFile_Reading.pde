PFont mainFont;
float SCALE;

//--//
byte[] bytes;
char[] chars;
String[] lines;
String allinString;
//--//

void setup() {
  size(1500, 1500);
  SCALE = ((width+height)/1000);
  mainFont = createFont("Fonts/VCR_OSD_MONO_1.001.ttf", 32);
  bytes = loadBytes("Text.txt");
  
  //--//
  chars = byteToChar(bytes);
  allinString = charsToString(chars);
  lines = charsToLines(chars);
  //--//
}

void draw() {
  background(0);
  fill(255);
  textFont(mainFont);
  textSize(12*SCALE);
  textAlign(LEFT, CENTER);
  text(allinString, width/25, height/2);
}
