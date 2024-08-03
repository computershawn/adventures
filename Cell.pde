class Cell {
  float posX, posY, s;
  color coco = color(0, 227, 255);
  boolean wut = random(1) > 0.5;
  int shapeType = random(1) > 0.9 ? 1 : 0;

  Cell(float _posX, float _posY, float _s) {
    posX = _posX;
    posY = _posY;
    s = _s;
    if (random(1) > 0.96) shapeType = 2;
    float n = random(1);
    if (n > 0.333) {
      if (n <= 0.667) {
        coco = color(255, 0, 121);
      } else {
        coco = color(255, 235, 0);
      }
    }
  }

  void concentrics(float val) {
    int n = int(map(val, minBright, maxBright, 0, 8));
    if (n > 0) {
      pg.strokeWeight(2);
      pg.noFill();
      pg.stroke(co2);
      pg.point(posX, posY);
      pg.strokeWeight(1);
      for (int i = 0; i < n; i++) {
        float diam = map(i, 0, n, 0.20 * s, 0.96 * s);
        pg.circle(posX, posY, diam);
      }
    }
  }

  void tri() {
    pg.beginShape();
    pg.noStroke();
    pg.fill(coco);
    pg.push();
    pg.translate(posX, posY);
    pg.vertex(-s / 2, -s / 2);
    pg.vertex(-s / 2, s / 2);
    pg.vertex(s / 2, s / 2);
    pg.endShape(CLOSE);
    pg.pop();
  }

  void render(float val, int w, int h) {
    int len = h - 1;
    int n = int(map(val, minBright, maxBright, 0, len));
    float incr = (float) s / (n - 1);
    float y0 = -0.5 * len;
    switch(shapeType) {
    case 0:
    default:
      pg.stroke(co2);
      pg.noFill();
      for (int i = 0; i < n; i++) {
        float y = y0 + i * incr;
        if (wut) {
          pg.line(posX - w / 2, posY + y, posX + w / 2, posY + y);
        } else {
          pg.line(posX + y, posY - h / 2, posX + y, posY + h / 2);
        }
      }
      break;
    case 1:
      concentrics(val);
      break;
    case 2:
      tri();
      break;
    }
    //pg.line(-w / 2, -h / 2, w / 2, h / 2);
    //pg.pop();
  }
}
