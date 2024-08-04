int wd, ht, CX, CY;
int s;  // Size of each cell
ArrayList<Cell> cells;
PGraphics pg;
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
int[][][] sequence;
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
  pg = createGraphics(wd, ht);
  cells = new ArrayList<Cell>();
  s = wd / tilesX;

  // Variable 'sequence' is a 3-dimensional array
  // of pixel brightness values over time
  sequence = getSequence(numFrames);

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      float posX = wd / tilesX * x + 0.5 * s;
      float posY = ht / tilesY * y + 0.5 * s;
      cells.add(new Cell(posX, posY, s));
    }
  }

  strokeWeight(2);
  noFill();
  stroke(co2);

  //noLoop();
  frameRate(6);
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  pg.background(co1);
  render(seqFrame);
  pg.endDraw();
  image(pg, 0, 0);

  // Draw a nice frame around the artwork
  rect(0.625 * s, 0.625 * s, wd - 1.25 * s, ht - 1.25 * s);

  seqFrame += 1;
  if (seqFrame == numFrames) {
    seqFrame = 0;
  }
}

void mousePressed() {
  //invert = !invert;
}
