float SCALE;
Image choices[] = new Image[9];
Image source;

void setup () {
  size(1500, 1000);
  //size(750, 500);
  SCALE = ((width+height)/225)*0.175; 
  imageMode(CENTER);

  //Gets the first image into place
  int spacing = int(SCALE*150);
  source = new Image("original.jpg", 100*SCALE);
  source.position = new PVector(width/5, height/5 + spacing);
  source.STROKE1 = color(225, 0, 0);
  source.STROKE2 = source.STROKE1;
  
  //Gets all of the other images into place, and then shuffles their order
  for (int i = 0; i < 9; i++) {
    choices[i] = new Image((i+1)+".jpg", 100*SCALE);
    choices[i].file.resize(source.file.width, source.file.height);
  }
  shuffleImages(choices);

  //Makes the grid of the choices of images
  //Because there's only 9, and not 49, it's not that bad to make it 'manually', line by line
  int gridStartX = width/2;
  int gridStartY = height/5;
  for (int i = 0; i < choices.length; i++) {
    if (i < 3) {
      choices[i].position = new PVector(gridStartX + spacing*(i-0), gridStartY + spacing*0);
    } else if (i < 6) {
      choices[i].position = new PVector(gridStartX + spacing*(i-3), gridStartY + spacing*1);
    } else if (i < 9) {
      choices[i].position = new PVector(gridStartX + spacing*(i-6), gridStartY + spacing*2);
    }
  }

  //Mashes every image together
  for (int i = 0; i < choices.length; i++) {
    XORImages(source, choices[i]);
  }
}

void XORImages(Image s, Image k) { 

  //Load the pixels of each image into their respective pixels lists
  s.file.loadPixels();
  k.file.loadPixels();

  //XOR each spot in the pixels list
  for (int i = 0; i < s.file.pixels.length; i++) {
    s.file.pixels[i] = s.file.pixels[i]^k.file.pixels[i];
  }

  //put the pixels back
  s.file.updatePixels();
  k.file.updatePixels();
}

void shuffleImages(Image[] imgs) {
  Image temp;
  int pick;
  for (int i = 0; i < imgs.length; i++) {
    pick = int(random(imgs.length)); //Pick a random spot in the list to put the current Image
    temp = imgs[i]; //Store the image that's going to have it's spot taken in a temp variable
    imgs[i] = imgs[pick]; //Move the chosen image into the current spot
    imgs[pick] = temp; //Put the image that had it's spot taken back into the spot where the other image came from
  }
}

//These last two are pretty self-explanatory
void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i = 0; i < choices.length; i++) {
      if (choices[i].mouseOver()) {
        XORImages(source, choices[i]);
      }
    }
  }
}

void draw() {
  background(220);
  for (int i = 0; i < choices.length; i++) {
    choices[i].update();
    choices[i].display();
  }
  source.update();
  source.display();
}
