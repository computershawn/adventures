void render(
  PGraphics in // the input PGraphics object
  //int tilesX, // the amount of cols
  //int tilesY // the amount of rows
  ) {

  PImage buffer = in.get();

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      int px = int(x * tileW);
      int py = int(y * tileH);
      color c = buffer.get(px, py);
      float val = invert ? brightness(c) : 255 - brightness(c);
      int index = y * tilesX + x;
      Cell cel = cells.get(index);
      cel.render(val, tileW, tileH);
    }
  }
}

float[] getBrightBounds(PImage img) {
  int dimension = img.width * img.height;
  img.loadPixels();
  float minBright = 1000;
  float maxBright = -1000;
  for (int i = 0; i < dimension; i++) {
    color co = img.pixels[i];
    float val = brightness(co);
    if (val < minBright) {
      minBright = val;
    }
    if (val > maxBright) {
      maxBright = val;
    }
  }

  return new float[]{minBright, maxBright};
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
  imageIndex += 1;
  if (imageIndex == seqLen) {
    imageIndex = 0;
  }
  filename = "seq/PC" + (seqStart + imageIndex) + ".JPG";
  IMG = loadImage(filename);
  IMG.resize(0, HT);

  float[] brightBounds = getBrightBounds(IMG);
  minBright = brightBounds[0];
  maxBright = brightBounds[1];
}

IntList[] getSequence(int len) {
  IntList[] temp = new IntList[len];
  PGraphics SCENE1 = createGraphics(WD, HT);

  for (int i = 0; i < len; i++) {
    updateImage();
    SCENE1.beginDraw();
    SCENE1.imageMode(CENTER);
    SCENE1.translate(CX, CY);
    SCENE1.image(IMG, 0, 0);
    SCENE1.endDraw();

    IntList wut = new IntList();
    //for (int j = 0; j < tilesX * tilesY; j++) {
    //  wut.append(round(random(15)));
    //}
    PImage buffer = SCENE1.get();

    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
        int px = int(x * tileW);
        int py = int(y * tileH);
        color c = buffer.get(px, py);
        float val = invert ? brightness(c) : 255 - brightness(c);
        wut.append(round(val));
        //int index = y * tilesX + x;
        //Cell cel = cells.get(index);
        //cel.render(val, tileW, tileH);
      }
    }
    temp[i] = wut;
  }
  return temp;
}


//PGraphics in, // the input PGraphics object
//int tilesX, // the amount of cols
//int tilesY // the amount of rows
//) {

//PImage buffer = in.get();

//for (int y = 0; y < tilesY; y++) {
//  for (int x = 0; x < tilesX; x++) {
//    int px = int(x * tileW);
//    int py = int(y * tileH);
//    color c = buffer.get(px, py);
//    float val = invert ? brightness(c) : 255 - brightness(c);
//    int index = y * tilesX + x;
//    Cell cel = cells.get(index);
//    cel.render(val, tileW, tileH);
//  }
//}
