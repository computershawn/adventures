PImage IMG;
PGraphics SCENE;
PFont FON;
int WD, HT, CX, CY;
String CHARS1 = "█▛▜▟▙▄▀▐▌▞▚▝▖▗";
//String CHARS2 = "█▓▒░▇▆▅▄▃▂_. ";
//String CHARS1 = "ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■";
//String CHARS1 = "│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌";
ArrayList<Cell> cells;
PGraphics pg;
int tilesX = 60; // 80; // the amount of cols
int tilesY = 60; // 80; // the amount of rows
float minBright = 0;
float maxBright = 0;
String filename = "PC307879.jpg"; // "me.jpg"; // "clouds.jpg";
boolean invert = true;
color co1 = invert ? 0 : 255;
color co2 = invert ? 255 : 0;

void setup() {
  size(720, 720);
  WD = width;
  HT = height;
  CX = WD / 2;
  CY = HT / 2;
  IMG = loadImage(filename);
  IMG.resize(WD, 0);
  FON = createFont("IBMPlexMono-Medium.ttf", 1000);
  SCENE = createGraphics(WD, HT);
  pg = createGraphics(WD, HT);
  cells = new ArrayList<Cell>();

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

  //pixelDensity(displayDensity());

  noLoop();
  //frameRate(2);
}

void draw() {
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

  rendererAscii(
    SCENE, // Input PGraphics object
    FON, // font to use
    22, // font size
    CHARS1, // charset
    tilesX, // cols
    tilesY, // rows
    #000000, // #f1f1f1, // background color
    #ffffff // foreground color
    );

  pg.endDraw();
  image(pg, 0, 0);
}
