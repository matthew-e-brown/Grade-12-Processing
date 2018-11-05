void setup(){
  println("setup entered");
  size(400,400);
  background(20);
}

void draw(){
}
  
void mousePressed(){
  println(mouseX, mouseY);
  if (mouseButton == LEFT){
    fill(255, 128, 0); 
  }
  else if (mouseButton == RIGHT){
    fill(0, 128, 255);
  }
  else if (mouseButton == CENTER){
    fill(0, 255, 128);
  }
  noStroke();
  ellipse( mouseX, mouseY, 2, 2 );
  text( "x: " + mouseX + " y: " + mouseY, mouseX + 2, mouseY );
  

  fill(g.backgroundColor);
  stroke(g.backgroundColor);
  rect(9, 9, 100, 15); 
  
  noStroke();
  fill(255);
  textAlign(LEFT, TOP);
  text("x: " + mouseX + " y: " + mouseY, 10, 10);
  
}

void keyPressed(){
  background(g.backgroundColor);
}