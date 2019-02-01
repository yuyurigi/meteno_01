class Starrysky {
  float x, y;
  float size;
  float zurex, zurey;
  color c1;
  int s;
  int number;
  float R;
  float ro;
  color strokeC = color(330, 100, 1); //線の色

  Starrysky(int _number) {
    x = random(width);
    y = random(height);
    size = random(8, 16);
    zurex = random(1, 3); //色のずれx値
    zurey = random(1, 3); //色のずれy値
    number = _number;
    int c = int(random(8));
    metenoColor(c);
    s = int(random(2));
    ro = random(360);
  }

  void display() {
    if (number < ss*0.6) {
      //丸の色部分
      noStroke();
      fill(c1);
      ellipse(x+zurex, y+zurey, size, size);
      //丸の線部分
      strokeWeight(2);
      noFill();
      stroke(strokeC);
      ellipse(x, y, size, size);
    } else {

      switch(s) {
      case 0: //黒い丸
        noStroke();
        fill(strokeC);
        ellipse(x, y, size, size);
        break;
      case 1: //黒い星
        pushMatrix();
        translate(x, y);
        rotate(radians(ro));
        fill(strokeC);
        stroke(strokeC);
        strokeWeight(4);
        strokeJoin(ROUND);
        beginShape();
        for (int i = 0; i < 10; i++) {
          if (i%2 == 0) {
            R = size*0.6;
          } else {
            R = size*0.6/2;
          }
          vertex(R * cos(radians(360*i/10)), R * sin(radians(360*i/10)));
        }
        endShape(CLOSE);
        popMatrix();
      }
    }
  }

  void metenoColor(int colorP) {
    switch(colorP) {
    case 0: //red
      c1 = color(0, 80, 100); //濃い色
      break;
    case 1: //yellow green
      c1 = color(147, 80, 99); //濃い色
      break;
    case 2: //yellow
      c1 = color(41, 79, 97); //濃い色
      break;
    case 3: //orange
      c1 = color(25, 80, 99); //濃い色
      break;
    case 4: //blue
      c1 = color(180, 79, 99); //濃い色
      break;
    case 5: //blue green
      c1 = color(174, 80, 99);
      break;
    case 6: //yellow orange
      c1 = color(36, 80, 99);
      break;
    case 7: //purple
      c1 = color(296, 79, 99); //濃い色
      break;
    }
  } //metenoColor_end
}
