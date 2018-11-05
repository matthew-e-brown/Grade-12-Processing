class Scoreblip extends TextBlock {
  PVector vel;
  int score;
  
  int framesActive = 0;
  
  Scoreblip(float x, float y, int score) {
    super(str(score), 80*SCALE, x, y, true);
    vel = new PVector(0, -5*SCALE);
    this.score = score;
  }

  void update() {
    pos.add(vel);
    framesActive++;
    opacity = map(framesActive, 0, 100, 255, 0);
  }
  
  
  
}
