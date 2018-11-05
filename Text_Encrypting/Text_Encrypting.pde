//  TEXT ENCRYPTOR
//  Matthew Brown, Bayside Secondary School
//  April 7-10, 2018

float SCALE; //Used to scale the screen for different resolutions

byte[][] ascii; //The first dimension of this array is as follows: 1 is plaintext, 2 is encrypted, 3 is unencrypted. 
char[][] chars; //This list follows the same dimensions. Obivously they are lists of bytes, so that's what the second dimension is.
String[] strings; //Because strings aren't stored as lists of characters/bytes, I can use 1, 2, and 3 to store the entire block at once.
TextBlock plainText, cipher, undone, pad, importExplain, saveExplain; //My custom Textblock class to make it easier to put entire blocks onscreen at once.

int stage = 0; //Keeps track of where in the program the user is at:
//0 is before any encrypting has been done. 1 means it is displaying the encrypted text. 2 means it is showing the UNencrypted text.

byte[] oneTimePad; //This is the list of bytes being XOR'd with text in order to encrypt the text.

Button encryptButton, newPadButton, saveButton, importButton; //This line is pretty explanatory, it defines buttons.

void setup() {
  size(1500, 1000); //(750, 500) is recommended for smaller (non-4K) reens
  //size(750, 500);
  SCALE = ((width+height)/225)*0.175;

  encryptButton = new Button(width/2, height/10, 120*SCALE, 40*SCALE, "Encrypt");
  newPadButton = new Button(width/2, height/5, 120*SCALE, 40*SCALE, "New Pad");
  saveButton = new Button(width/4*3, height/10, 120*SCALE, 40*SCALE, "Save");
  importButton = new Button(width/4, height/10, 120*SCALE, 40*SCALE, "Import");

  ascii = new byte[3][(loadBytes("PlainText.txt").length)]; //first [] is for 3 different versions of text
  chars = new char[3][(loadBytes("PlainText.txt").length)]; //second [] is where the bytes and chars of the text file will go
  strings = new String[3]; //3 different versions: untouched, ciphered, unencrypted

  //Load the bytes into the sketch and create a char and string version of it using custom methods
  ascii[0] = loadBytes("PlainText.txt");
  chars[0] = byteToChar(ascii[0]);
  strings[0] = charsToString(chars[0]);
  //Create the textblock to show it to the user
  plainText = new TextBlock(width/2, height/2, 26*SCALE, color(50), strings[0]);
  
  //Generate the oneTimePad and then create the textblock that shows it to the user
  oneTimePad = genPad(ascii[0]);
  pad = new TextBlock(width/2, height/10*9, 14*SCALE, color(50), byteToString(oneTimePad));

  //This is me using my TextBlock class to explain what the buttons do
  importExplain = new TextBlock(width/4, height/10*1.5, 6.5*SCALE, color(128), "This will import text saved with the/NLsave button. It will still be encrypted.");
  saveExplain = new TextBlock(width/4*3, height/10*1.5, 6.5*SCALE, color(128), "This will save text to be re-imported/NLlater. It will save the encrypted text and pad.");
}

void draw() {
  background(200);
  
  //This large chunk simply displays the correct text (if stage 0 then use ascii[0] for freshly loaded bytes, etc.)
  if (stage == 0) {
    fill(50);
    textSize(14*SCALE);
    text("Plain text from file", width/2, height/2*0.825);
    plainText.display();
  } else if (stage == 1) {
    fill(50);
    textSize(14*SCALE);
    text("Text XOR'd with OneTimePad", width/2, height/2*0.825);
    cipher.display();
  } else if (stage == 2) {
    fill(50);
    textSize(14*SCALE);
    text("Text re-XOR'd with OneTimePad", width/2, height/2*0.825);
    undone.display();
    fill(128);
    textSize(8*SCALE);
    text("(If you hit Encrypt again, this is what will be XOR'd with the OneTimePad)", width/2, height/2*1.1);
  }
  fill(50);
  textSize(12*SCALE);
  text("One Time Pad:", width/2, height/10*8.25);
  fill(128);
  textSize(8*SCALE);
  text("(whose bytes will be XOR'd with the bytes of the string)", width/2, height/10*8.5);
  pad.display();

  //Changes whether the button is about to unencrypt of encrypt (purely visual)
  if (stage == 1) {
    encryptButton.text = "Unencrypt";
    encryptButton.SIZE = 18*SCALE;
  } else {
    encryptButton.text = "Encrypt";
    encryptButton.SIZE = 22*SCALE;
  }
  encryptButton.display();

  //Changes the color of buttons from red to green and vice versa when the user can't click on them
  if (stage == 1) {
    newPadButton.FILL = color(255, 128, 128);
    newPadButton.STROKE = color(100);
  } else {
    newPadButton.FILL = color(128, 230, 128);
    newPadButton.STROKE = color(255, 255, 128);
  }
  newPadButton.display();

  if (stage == 1) {
    saveButton.FILL = color(128, 230, 128);
    saveButton.STROKE = color(255, 255, 128);
  } else {
    saveButton.FILL = color(255, 128, 128);
    saveButton.STROKE = color(100);
  }
  saveButton.display();
  saveExplain.display();

  importButton.display();
  importExplain.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (encryptButton.mouseOver()) {
      if (stage == 0) {
        ascii[1] = encrypt(ascii[0], oneTimePad); //Custom method to encrpyt text using a onetimepad that's made using genPad() at the start
        chars[1] = byteToChar(ascii[1]); //These two lines convert to a char just in case and then to a string (even though I also made a byteToString())
        strings[1] = charsToString(chars[1]);
        cipher = new TextBlock(width/2, height/2, 26*SCALE, color(50), strings[1]);
        stage++;
      } else if (stage == 1) {
        ascii[2] = encrypt(ascii[1], oneTimePad); //Technically this unencrypts the text, but when using XOR it works backwards
        chars[2] = byteToChar(ascii[2]);
        strings[2] = charsToString(chars[2]);
        undone = new TextBlock(width/2, height/2, 26*SCALE, color(50), strings[2]);
        stage++;
      } else if (stage == 2) {
        stage = 0; //These two lines basically act double duty: re-run the code from the if (stage == 0) block
        mousePressed(); //and also make sure the variable doesn't get too high
      }
    } else if (newPadButton.mouseOver()) {
      if (stage != 1) {
        oneTimePad = genPad(ascii[0]); //Simply regenerates a new onetimepad (since it's random) from the original bytes list
        pad.allText = byteToString(oneTimePad); //changes the text in the "pad" textblock
      }
    } else if (saveButton.mouseOver()) {
      if (stage == 1) {
        saveData(); //Function to create files
      }
    } else if (importButton.mouseOver()) {
      loadData(); //Function to load encrypted text and onetimepad from files
    }
  }
}

void saveData() { //Saves the Ascii and OneTimePad of the encrypted text to files
  saveBytes("SavedEncrypted.txt", ascii[1]);
  saveBytes("SavedEncryptor.txt", oneTimePad);
}

void loadData() { //Grabs the bytes of the saved encrypted and onetimepad and resets the right variables appropriately to pick up from there.
  ascii[1] = loadBytes("SavedEncrypted.txt");
  oneTimePad = loadBytes("SavedEncryptor.txt");
  ascii[0] = encrypt(ascii[1], oneTimePad);

  chars[1] = byteToChar(ascii[1]);
  strings[1] = charsToString(chars[1]);

  stage = 1;

  cipher = new TextBlock(width/2, height/2, 26*SCALE, color(50), strings[1]);
  pad = new TextBlock(width/2, height/10*9, 14*SCALE, color(50), byteToString(oneTimePad));
}
