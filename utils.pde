//void render(
//  PGraphics in // the input PGraphics object
//  //int tilesX, // the amount of cols
//  //int tilesY // the amount of rows
//  ) {

//  PImage buffer = in.get();

//  for (int y = 0; y < tilesY; y++) {
//    for (int x = 0; x < tilesX; x++) {
//      int px = int(x * tileW);
//      int py = int(y * tileH);
//      color c = buffer.get(px, py);
//      float val = invert ? brightness(c) : 255 - brightness(c);
//      int index = y * tilesX + x;
//      Cell cel = cells.get(index);
//      cel.render(val, tileW, tileH);
//    }
//  }
//}

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
  int minBright = 1000;
  int maxBright = -1000;
  for (int i = 0; i < dimension; i++) {
    color co = img.pixels[i];
    int val = (int) brightness(co);
    if (val < minBright) {
      minBright = val;
    }
    if (val > maxBright) {
      maxBright = val;
    }
  }

  return new int[]{minBright, maxBright};
}

//IntList[] getSequence(int len) {
//  IntList[] temp = new IntList[len];
//  for (int i = 0; i < len; i++) {
//    IntList wut = new IntList();
//    for (int j = 0; j < tilesX * tilesY; j++) {
//      wut.append(round(random(15)));
//    }
//    temp[i] = wut;
//  }
//  return temp;
//}

void updateImage() {
  //imageIndex += 1;
  //if (imageIndex == seqLen) {
  //  imageIndex = 0;
  //}
  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }
  filename = "seq/PC" + (seqStart + seqFrame) + ".JPG";
  IMG = loadImage(filename);
  IMG.resize(0, HT);

  int[] brightBounds = getBrightBounds(IMG);
  minBright = brightBounds[0];
  maxBright = brightBounds[1];
}

int[][][] getSequence(int len) {
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
        //int px = int(x * 1);
        //int py = int(y * 1);
        color c = buffer.get(px, py);
        float val = invert ? brightness(c) : 255 - brightness(c);
        temp[i][y][x] = round(val);
      }
    }
    //temp[i] = wut;
  }
  return temp;
}
