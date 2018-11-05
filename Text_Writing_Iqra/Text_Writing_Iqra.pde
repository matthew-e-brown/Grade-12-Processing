void setup(){
  size(1000,200);
}

void draw(){  
  background(0);
  textSize(50);
  text(mouseText, mouseX, mouseY);
}


String mouseText = "";
String word = "";

/**so in java you can't really change the size of an array, it's fixed 
  to 1 atm.. either you can create a new array again.. or use an "arrayList" which
  has different functions that let you modify an array**/
  
//char[] letters = new char[1];  //this is your standard array
ArrayList<Character> letters = new ArrayList<Character>();   //this is an arrayList

int place = 0;

void mouseClicked(){
  println("Mouse Button: " + mouseButton);
}

void write(char c){
    word += c;  //add that character to the word
  //word = join(str(letters), "");
}


//clearing the entire word
void clearWord() {
  word = "";
}

//if you wanna clear the last letter instead of the entire word
void clearLastLetter() {
  word = word.substring(0, word.length() - 1);
}

void keyPressed(){
  //println("Key Code: " + keyCode + "\t\tKey " + key);
  if (key != ENTER && key != BACKSPACE){
    //expand(letters, ((letters.length)+1));
    //letters[place] = key;
    letters.add(key);  //arrayList way of doing this
    place += 1;
    write(key);  //no need to keep track of the "place" anymore, arrayList does it for you
    mouseText = word;  
  }
  if (key == BACKSPACE){
    //clearWord();  //clears the word
    clearLastLetter();  //backspaces letter
    mouseText = word;
  }
  System.out.println("word: " + word);
}