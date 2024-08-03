void render(
  PGraphics in, // the input PGraphics object
  int tilesX, // the amount of cols
  int tilesY, // the amount of rows
  color bg, // the background-color
  color fg // the foreground-color
  ) {

  PGraphics pg;

  //pg = createGraphics(width, height);
  //pg.beginDraw();
  //pg.background(bg);
  //pg.fill(fg);
  //pg.noStroke();

  int tileW = width / tilesX;
  int tileH = height / tilesY;

  //pg.textFont(fnt);
  //pg.textSize(fontSize);
  //pg.textAlign(CENTER, CENTER);
  //pg.translate(width/2, height/2);

  PImage buffer = in.get();

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      int px = int(x * tileW);
      int py = int(y * tileH);
      color c = buffer.get(px, py);
      float val = invert ? brightness(c) : 255 - brightness(c);
      ////char ch = chars.charAt(int(map(brightness(c), 0, 255, 0, chars.length()-1)));
      ////float diam = map(brightness(c), 0, 255, 1, 12);

      //float posX = map(x, 0, tilesX, -spread, spread);
      //float posY = map(y, 0, tilesY, -spread, spread);

      int index = y * tilesX + x;
      Cell cel = cells.get(index);
      cel.render(val, tileW, tileH);
      //pg.text(ch, 0, 0);
      //pg.circle(0, 0, diam);
      //pg.rect(0, 0, diam, diam);
      //pg.fill(brightness(c));
      //pg.rect(posX, posY, tileW, tileH);
    }
  }
}

float[] getBrightBounds(
  PImage img,
  //PGraphics in, // the input PGraphics object
  int tilesX, // the amount of cols
  int tilesY // the amount of rows
  ) {

  //tower = loadImage("tower.jpg");
  int dimension = img.width * img.height;
  img.loadPixels();
  float minBright = 1000;
  float maxBright = -1000;
  for (int i = 0; i < dimension; i++) {
    //tower.pixels[i] = color(0, 0, 0);
    color co = img.pixels[i];
    float val = brightness(co);
    if (val < minBright) {
      minBright = val;
    }
    if (val > maxBright) {
      maxBright = val;
    }
  }

  //int tileW = width / tilesX;
  //int tileH = height / tilesY;

  //PImage buffer = in.get();
  //float minBright = 1000;
  //float maxBright = -1000;

  //for (int y = 0; y < tilesY; y++) {
  //  for (int x = 0; x < tilesX; x++) {
  //    int px = int(x * tileW);
  //    int py = int(y * tileH);
  //    color c = buffer.get(px, py);
  //    float val = brightness(c);
  //    if (val < minBright) {
  //      minBright = val;
  //    }
  //    if (val > maxBright) {
  //      maxBright = val;
  //    }
  //  }
  //}

  return new float[]{minBright, maxBright};
}
