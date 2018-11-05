class Block {
  PImage BLOCK;
  PVector pos, vel, acc;

  boolean alive = true;
  boolean hit = false; //works along side the alive boolean to determine if it's all the way dead or on it's way down

  int blockNumber;

  Block(float x, float y, int blockNumber) { //constructor
    this.pos = new PVector(x, y);
    this.blockNumber = blockNumber;

    BLOCK = loadImage("Sprites/Block.png");
    BLOCK.resize(width/30, width/30);

    vel = new PVector(0, 0);
    acc = new PVector(0, 0.35*SCALE);
  }

  void update() {
    if (hit && pos.y <= height) {
      vel.add(acc);
      pos.add(vel);
    }
    if (pos.y > height) {
      alive = false;
      hit = false;
    }
  }

  void display() {
    if (alive) {
      image(BLOCK, pos.x, pos.y);
    }
  }
}
