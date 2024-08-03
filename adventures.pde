PImage IMG;
PGraphics SCENE;
int WD, HT, CX, CY;
ArrayList<Cell> cells;
PGraphics pg;
int tilesX = 60; // 80; // the amount of cols
int tilesY = 60; // 80; // the amount of rows
float minBright = 0;
float maxBright = 0;
int seqStart = 307782;
int imageIndex = 0;
int seqLen = 244;
String filename = "seq/PC" + seqStart + ".JPG";
boolean invert = true;
color co1 = invert ? #1C85AD : 255;
color co2 = invert ? 255 : #1C85AD;
IntList[] sequence;

void setup() {
  size(720, 720);
  WD = width;
  HT = height;
  CX = WD / 2;
  CY = HT / 2;
  IMG = loadImage(filename);
  //IMG.resize(WD, 0);
  //IMG.resize(0, HT);
  SCENE = createGraphics(WD, HT);
  pg = createGraphics(WD, HT);
  cells = new ArrayList<Cell>();
  
  sequence = getSequence(240);
  println(sequence[24].get(3599));

  float[] brightBounds = getBrightBounds(IMG, tilesX, tilesY);
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
  updateImage();
  SCENE.beginDraw();
  SCENE.background(#000000);
  SCENE.imageMode(CENTER);
  SCENE.translate(CX, CY);
  SCENE.image(IMG, 0, 0);
  SCENE.endDraw();

  pg.beginDraw();
  pg.noStroke();
  //pg.strokeWeight(0.5);
  pg.background(co1);

  render(
    SCENE, // Input PGraphics object
    tilesX, // cols
    tilesY // rows
    );

  pg.endDraw();
  image(pg, 0, 0);
}

void updateImage() {
  imageIndex += 1;
  if (imageIndex == seqLen) {
    imageIndex = 0;
  }
  filename = "seq/PC" + (seqStart + imageIndex) + ".JPG";
  //println(filename);
  IMG = loadImage(filename);
  //IMG.resize(0, HT);
  //SCENE = createGraphics(WD, HT);
  //pg = createGraphics(WD, HT);
  //cells = new ArrayList<Cell>();

  float[] brightBounds = getBrightBounds(IMG, tilesX, tilesY);
  minBright = brightBounds[0];
  maxBright = brightBounds[1];
}

void mousePressed() {
  //invert = !invert;
}
