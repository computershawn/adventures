int wd, ht, CX, CY;
int s;  // Size of each cell

int tilesX;  // Width in pixels of the input image file
int tilesY;  // Height in pixels of the input image file
int tileW;   // Width of a single tile
int tileH;   // Height of a single tile
int minBright = 1000;  // Min pixel brightness of all images in sequence
int maxBright = -1000; // Max pixel brightness of all images in sequence
int seqStart = 307782;
int numFrames = 240;

boolean invert = true;
color co1 = invert ? #1C85AD : 255;
color co2 = invert ? 255 : #1C85AD;

PGraphics[] imageSequence;
int seqFrame = 0;

void setup() {
  size(720, 720);
  int[] dims = getImageDims();

  wd = width;
  ht = height;
  tilesX = dims[0];
  tilesY = dims[1];
  tileW = wd / tilesX;
  tileH = ht / tilesY;
  s = wd / tilesX;

  imageSequence = getImageSequence(numFrames);

  strokeWeight(2);
  noFill();
  stroke(co2);

  frameRate(12);
}

void draw() {
  image(imageSequence[seqFrame], 0, 0);

  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }
}

void mousePressed() {
  //invert = !invert;
}
