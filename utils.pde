void render(int currentIndex) {
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

// Get the lowest and highest pixel brightness of the image
int[] getBrightBounds(PImage img) {
  int numPixels = img.width * img.height;
  img.loadPixels();
  int low = minBright;
  int high = maxBright;
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
  PImage img = loadImage(filename);

  int[] brightBounds = getBrightBounds(img);
  minBright = brightBounds[0];
  maxBright = brightBounds[1];

  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }

  return img;
}

int[][][] getSequence(int len) {
  int[][][] temp = new int[len][tilesY][tilesX];
  PGraphics SCENE = createGraphics(tilesX, tilesY);

  for (int i = 0; i < len; i++) {
    PImage img = loadNextImage();
    SCENE.beginDraw();
    SCENE.image(img, 0, 0);
    SCENE.endDraw();

    PImage buffer = SCENE.get();

    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
        color c = buffer.get(x, y);
        float val = invert ? brightness(c) : 255 - brightness(c);
        temp[i][y][x] = round(val);
      }
    }
  }

  return temp;
}
