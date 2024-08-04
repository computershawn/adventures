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

// Load an image file and return it as a PImage
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

// Read a sequence of image files and populate a 3-dimensional
// array. The first dimension represents frame number (time).
// The second dimension is y, and the third dimension is x. The
// value at sequence[frame][y][x] is a pixel brightness
int[][][] getSequence(int len) {
  // Variable 'temp' is a 3-dimensional array
  // of pixel brightness values over time
  int[][][] temp = new int[len][tilesY][tilesX];
  PGraphics SCENE = createGraphics(tilesX, tilesY);

  for (int i = 0; i < len; i++) {
    PImage img = loadNextImage();
    SCENE.beginDraw();
    SCENE.image(img, 0, 0);
    SCENE.endDraw();

    PImage buffer = SCENE.get();

    for (int y = 1; y < tilesY - 1; y++) {
      for (int x = 1; x < tilesX - 1; x++) {
        color c = buffer.get(x, y);
        float val = invert ? brightness(c) : 255 - brightness(c);
        temp[i][y][x] = round(val);
      }
    }
  }

  return temp;
}

// Get width and height of input images
int[] getImageDims() {
  String filename = "seq/PC" + seqStart + ".jpg";
  PImage img = loadImage(filename);

  return new int[]{img.width, img.height};
}

// Generate all frames of the animation and return
// them as an array of PGraphics items
PGraphics[] getImageSequence(int len) {
  int[][][] sequence = getSequence(numFrames);
  PGraphics[] allFramesTemp = new PGraphics[len];

  ArrayList<Cell> cells = new ArrayList<Cell>();
  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      float posX = wd / tilesX * x + 0.5 * s;
      float posY = ht / tilesY * y + 0.5 * s;
      cells.add(new Cell(posX, posY, s));
    }
  }

  for (int j = 0; j < numFrames; j++) {
    PGraphics scn = createGraphics(wd, ht);
    scn.beginDraw();
    scn.noStroke();
    scn.background(co1);
    int[][] temp2 = sequence[j];

    for (int y = 0; y < temp2.length; y++) {
      for (int x = 0; x < temp2[y].length; x++) {
        int index = y * tilesX + x;
        Cell cel = cells.get(index);
        int val = temp2[y][x]; // Brightness at this x/y coordinate
        cel.render(val, tileW, tileH, scn);
      }
    }

    // Draw a nice frame around the artwork
    scn.rect(0.625 * s, 0.625 * s, wd - 1.25 * s, ht - 1.25 * s);
    scn.endDraw();

    allFramesTemp[j] = scn;
  }

  return allFramesTemp;
}
