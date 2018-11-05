void paint(String condition) {
  if (condition == "paint") {
    if (!rocketArray[r].launched) {
      colorMode(HSB, 360, 100, 100);

      color c = color(
        floor(random(0, 360)), 
        floor(random(0, 100)), 
        floor(random(10, 100))
        );
      color c1 = color(255);

      curFill = c;

      if (hue(c) <= 179) {
        c1 = color(hue(c) + 180, saturation(c), brightness(c));
      } else if (hue(c) < 360 && hue(c) > 179) {
        c1 = color(hue(c) - 180, saturation(c), brightness(c));
      }

      curStroke = c1;
      rocketArray[r].fill = curFill;
      rocketArray[r].stroke = curStroke;
    }
  }

  if (condition == "paintAll") {
    for (int p = 0; p < rocketArray.length; p++) {
      if (!rocketArray[p].launched) {
        colorMode(HSB, 360, 100, 100);

        color c = color(
          floor(random(0, 360)), 
          floor(random(0, 100)), 
          floor(random(10, 100))
          );
        color c1 = color(255);

        curFill = c;

        if (hue(c) <= 179) {
          c1 = color(hue(c) + 180, saturation(c), brightness(c));
        } else if (hue(c) < 360 && hue(c) > 179) {
          c1 = color(hue(c) - 180, saturation(c), brightness(c));
        }

        curStroke = c1;
        rocketArray[p].fill = curFill;
        rocketArray[p].stroke = curStroke;
      }
    }
  }

  if (condition == "clear") {
    colorMode(RGB);
    rocketArray[r].fill = color(255);
    rocketArray[r].stroke = color(0);
  }

  if (condition == "clearAll") {
    for (int i = 0; i<rocketArray.length; i++) {
      if (!rocketArray[i].launched) {
        rocketArray[i].fill = color(255);
        rocketArray[i].stroke = color(0);
      }
    }
  }
  colorMode(RGB, 255, 255, 255);
}