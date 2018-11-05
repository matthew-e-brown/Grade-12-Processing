

//TextBlock syntax: float x_, float y_, float size_, int lines_, color fillColor_, String allText_, use /NL for a new line

TextBlock controlText = new TextBlock(
  width/2, height/2, TEXTSCALEFACTOR, //x, y, size
  color(255), //color
  "Q: Clear selected/NLW: Clear all/NLA: Paint selected/NLS: Paint all/NLZ: Launch selected/NLX: Launch all/NLP: Pause/Unpause game"
  );

TextBlock scoreText = new TextBlock(
  15, 15, TEXTSCALEFACTOR*(25/12), //x, y, size
  color(255), //color
  "Total Launches: " + rocketTotal + "/NLScore: " + rocketScore + "/NLEfficiency: 0%"
  );

TextBlock infoText = new TextBlock(
  width, TEXTSCALEFACTOR*(3/12), TEXTSCALEFACTOR*(12.5/12.0), //x, y, size
  color(0, 255, 0), //
  "0 FPS/NL" + J + " Rockets/NL" + K + " Enemies"
  );