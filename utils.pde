void rendEnder(int currentIndex) {

  //PImage buffer = in.get();
  int[][] temp = sequence[currentIndex];

  for (int y = 0; y < temp.length; y++) {
    for (int x = 0; x < temp[y].length; x++) {
      //int px = int(x * tileW);
      //int py = int(y * tileH);
      //color c = buffer.get(px, py);
      //float val = invert ? brightness(c) : 255 - brightness(c);
      int index = y * tilesX + x;
      Cell cel = cells.get(index);
      cel.render(temp[y][x], tileW, tileH);
    }
  }
}

int[] getBrightBounds(PImage img) {
  int dimension = img.width * img.height;
  img.loadPixels();
  int low = 1000;
  int high = -1000;
  for (int i = 0; i < dimension; i++) {
    color co = img.pixels[i];
    int val = (int) brightness(co);
    if (val < low) {
      low = val;
    }
    if (val > high) {
      high = val;
    }
  }

  return new int[]{low, high};
}

void updateImage() {
  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }
  filename = "seq/PC" + (seqStart + seqFrame) + ".jpg";
  IMG = loadImage(filename);
  IMG.resize(0, HT);

  int[] brightBounds = getBrightBounds(IMG);
  minBright = min(brightBounds[0], minBright);
  maxBright = max(brightBounds[1], maxBright);
}

int[][][] getSequence(int len) {
  //println("tilesX " + tilesX);
  //println("tilesY " + tilesY);
  //println("tileW " + tileW);
  //println("tileH " + tileH);
  int[][][] temp = new int[len][tilesY][tilesX];
  PGraphics SCENE1 = createGraphics(WD, HT);

  for (int i = 0; i < len; i++) {
    updateImage();
    SCENE1.beginDraw();
    SCENE1.imageMode(CENTER);
    SCENE1.translate(CX, CY);
    SCENE1.image(IMG, 0, 0);
    SCENE1.endDraw();

    PImage buffer = SCENE1.get();

    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
        int px = int(x * tileW);
        int py = int(y * tileH);
        //int px = int(x);
        //int py = int(y);
        color c = buffer.get(px, py);
        float val = invert ? brightness(c) : 255 - brightness(c);
        temp[i][y][x] = round(val);
      }
    }
  }
  return temp;
}
