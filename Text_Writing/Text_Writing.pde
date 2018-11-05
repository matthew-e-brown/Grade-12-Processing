void setup(){
  size(1000,200);
}

void draw(){
  colorMode(RGB);
  background(0);
  
  colorMode(HSB, 360, 100, 100);
  c1 = floor(map(mouseX, 0, width, 0, 360));
 
  textSize(50);
  fill(c1, 100, 100);
  textAlign(LEFT, BOTTOM);
  
  if (letters.size() ==0){
    text("Type something!", mouseX, mouseY);
  } else if (word != ""){
  text(word, mouseX, mouseY);
  }
}

String word = "";

float c1, c2, c3;

ArrayList<Character> letters = new ArrayList<Character>();

void write(char c){
    word += c;
}

void clearWord() {
  word = "";
}

void clearLastLetter() {
  if (word.length() != 0){
    word = word.substring(0, word.length() - 1);
  } else {return;}
}

void keyPressed(){
  if (keyCode >= 32 && keyCode <= 126){
    letters.add(key);
    write(key);
    }
  if (key == BACKSPACE){
    clearLastLetter();
  }
  /** Debugging */
  System.out.println("word: " + word);
  System.out.println("keycode: " + keyCode);
  
}