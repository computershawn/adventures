// Update each cell's contents based on pixel brightness
void render(int currentIndex) {
  int[][] temp = sequence[currentIndex];

  for (int y = 0; y < temp.length; y++) {
    for (int x = 0; x < temp[y].length; x++) {
      int index = y * tilesX + x;
      Cell cel = cells.get(index);
      int val = temp[y][x]; // Brightness at this x/y coordinate
      cel.render(val, tileW, tileH);
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
  
  //int imageWd = img.width;
  //int imageHt = img.height;
  
  println(img.width + " " + img.height);
  
  return new int[]{img.width, img.height};

  //int[] brightBounds = getBrightBounds(img);
  //minBright = brightBounds[0];
  //maxBright = brightBounds[1];

  //seqFrame += 1;
  //if (seqFrame == numFrames) {
  //  seqFrame = 0;
  //}

  //return img;
}
