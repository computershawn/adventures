void render(int currentIndex) {

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
  int numPixels = img.width * img.height;
  img.loadPixels();
  int low = 1000;
  int high = -1000;
  for (int i = 0; i < numPixels; i++) {
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

PImage loadNextImage() {
  String filename = "seq/PC" + (seqStart + seqFrame) + ".jpg";
  PImage IM = loadImage(filename);
  IM.resize(0, HT);

  int[] brightBounds = getBrightBounds(IM);
  minBright = min(brightBounds[0], minBright);
  maxBright = max(brightBounds[1], maxBright);

  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }

  return IM;
}

int[][][] getSequence(int len) {
  int[][][] temp = new int[len][tilesY][tilesX];
  PGraphics SCENE = createGraphics(WD, HT);

  for (int i = 0; i < len; i++) {
    PImage im = loadNextImage();
    SCENE.beginDraw();
    SCENE.imageMode(CENTER);
    SCENE.translate(CX, CY);
    SCENE.image(im, 0, 0);
    SCENE.endDraw();

    PImage buffer = SCENE.get();

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
