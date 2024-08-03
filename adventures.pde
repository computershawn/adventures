PImage IMG;
int WD, HT, CX, CY;
ArrayList<Cell> cells;
PGraphics pg;
int tilesX = 60; // 80; // the amount of cols
int tilesY = 60; // 80; // the amount of rows
int tileW;
int tileH;
int minBright = 0;
int maxBright = 0;
int seqStart = 307782;
//int imageIndex = 0;
//int seqLen = 244;
int numFrames = 240;
String filename = "seq/PC" + seqStart + ".JPG";
boolean invert = true;
color co1 = invert ? #1C85AD : 255;
color co2 = invert ? 255 : #1C85AD;
//IntList[] sequence;
int[][][] sequence;
int seqFrame = 0;

void setup() {
  size(720, 720);
  WD = width;
  HT = height;
  tileW = WD / tilesX;
  tileH = HT / tilesY;
  CX = WD / 2;
  CY = HT / 2;
  //IMG = loadImage(filename);
  //IMG.resize(WD, 0);
  //IMG.resize(0, HT);
  pg = createGraphics(WD, HT);
  cells = new ArrayList<Cell>();

  sequence = getSequence(numFrames);

  int[] brightBounds = getBrightBounds(IMG);
  minBright = brightBounds[0];
  maxBright = brightBounds[1];

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      float s = WD / tilesX;
      float posX = WD / tilesX * x + 0.5 * s;
      float posY = HT / tilesY * y + 0.5 * s;
      cells.add(new Cell(posX, posY, s));
    }
  }

  //noLoop();
  frameRate(8);
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  //pg.strokeWeight(0.5);
  pg.background(co1);

  //render(SCENE);
  rendEnder(seqFrame);

  pg.endDraw();
  image(pg, 0, 0);
  
  seqFrame += 1;
  if(seqFrame == numFrames) {
    seqFrame = 0;
  }
}

void mousePressed() {
  //invert = !invert;
}
