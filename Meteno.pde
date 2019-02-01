class Meteno implements Comparable {
  float x, y;
  float zurex, zurey; //色のずれ
  float vely;
  int size; //直径
  float n;
  float s; //スケール値
  float velx = 0;
  float xNoise;
  float ro; //回転
  color c1, c2, c3, c4; //メテノの色（濃い、中間、薄い、模様の色）
  color strokeC = color(330, 100, 1); //線の色
  int sb; //メテノの裏表
  PGraphics pg1, pg2; //マスク
  float strokeW = 2; //線の太さ

  //コンストラクタ
  Meteno(float _x, float _y, float _vely, int _size, int _col) {
    x = _x;
    y = _y;
    vely = _vely;
    size = _size;
    if (size > 40) {
      xNoise = random(0.05); //横揺れ
    } else {
      xNoise = map(vely, minVel, maxVel, 0.001, 0.05); //サイズが40以下の小さいメテノはあまり揺れないようにする
    }
    ro = random(TWO_PI); //回転
    zurex = random(1, 5); //ずれ
    zurey = random(1, 5);
    sb = int(random(2)); //メテノの裏表
    shapeMode(CENTER);
    imageMode(CENTER);
    metenoColor(_col);
    metenoMask();
    s = 0.01*size;
  }

  void setRotate(float rot) { //回転設定
    ro = rot;
  }

  void setFace(int face) { //メテノの裏表設定,　0=表, 1=裏
    sb = face;
  }

  void move() {
    n = noise(velx)*15.0; //メテノが横に揺れ動く数値
    y -= vely;
    velx = velx + xNoise;

    if (y < 0 - size/2) {
      y = height + size/2;
      x = random(width);
    }
  }

  void display() {
    pushMatrix();
    translate(x+n, y);
    
    pushMatrix();
    rotate(ro);
    scale(s);
    fill(back); 
    noStroke();
    shape(metenoSvg[0], 0, 0);
    popMatrix();

    pushMatrix(); //メテノ色部分
    translate(zurex, zurey);
    scale(s);
    rotate(ro);

    if (size > 40) {
      image(pg1, 0, 0);
    } else {
      fill(c1); 
      noStroke();
      shape(metenoSvg[0], 0, 0);
    }

    popMatrix();

    rotate(ro);
    scale(s);
    strokeWeight((1.0 / s) * strokeW);
    noFill();
    stroke(strokeC); //輪郭
    shape(metenoSvg[0], 0, 0);

    if (sb == 0 && size > 40) { //メテノ表 && サイズが４０以上
      noStroke();
      fill(c2);
      shape(metenoSvg[1], 0, 0); //目
      fill(c3);
      shape(metenoSvg[2], 0, 0); //白目
      fill(c3);
      shape(metenoSvg[3], 0, 0); //くち
      strokeWeight(1);
      strokeJoin(ROUND);
      stroke(c4);
      fill(c4);
      shape(metenoSvg[4], 0, 0); //模様
    } else if (sb == 1 && size > 40) { //メテノ裏 && サイズが４０以上
      strokeWeight(1);
      strokeJoin(ROUND);
      stroke(c4);
      fill(c4);
      shape(metenoSvg[5], 0, 0); //模様
    }

    popMatrix();
  }

  void metenoColor(int colorP) {
    switch(colorP) {
    case 0: //red
      c1 = color(0, 80, 100); //濃い色
      c2 = color(0, 40, 100); //中間色
      c3 = color(0, 10, 100); //薄い色
      c4 = color(0, 80, 90); //模様の色
      break;
    case 1: //yellow green
      c1 = color(147, 80, 99); //濃い色
      c2 = color(147, 40, 99); //中間色
      c3 = color(147, 10, 99); //薄い色
      c4 = color(147, 80, 82); //模様の色
      break;
    case 2: //yellow
      c1 = color(41, 79, 97); //濃い色
      c2 = color(41, 40, 97); //中間色
      c3 = color(41, 10, 97); //薄い色
      c4 = color(41, 79, 87); //模様の色
      break;
    case 3: //orange
      c1 = color(25, 80, 99); //濃い色
      c2 = color(25, 40, 99); //中間色
      c3 = color(25, 10, 99); //薄い色
      c4 = color(25, 72, 89); //模様の色
      break;
    case 4: //blue
      c1 = color(180, 79, 99); //濃い色
      c2 = color(180, 40, 99); //中間色
      c3 = color(180, 5, 99); //薄い色
      c4 = color(180, 79, 89); //模様の色
      break;
    case 5: //blue green
      c1 = color(174, 80, 99);
      c2 = color(174, 40, 99);
      c3 = color(174, 10, 99);
      c4 = color(174, 80, 89);
      break;
    case 6: //yellow orange
      c1 = color(36, 80, 99);
      c2 = color(36, 40, 99);
      c3 = color(36, 10, 99);
      c4 = color(36, 80, 89);
      break;
    case 7: //purple
      c1 = color(296, 79, 99); //濃い色
      c2 = color(296, 40, 99); //中間色
      c3 = color(296, 10, 99); //薄い色
      c4 = color(296, 77, 91); //模様の色
      break;
    }
  } //metenoColor_end

  void metenoMask() {
    pg1 = createGraphics(100, 100);
    pg2 = createGraphics(100, 100);

    pg1.beginDraw();
    pg1.background(c3);
    pg1.ellipseMode(CENTER);
    pg1.noStroke();
    pg1.fill(c2);
    pg1.ellipse(100/2, 100/2, 100*0.8, 100*0.8);
    pg1.fill(c1);
    pg1.ellipse(100/2, 100/2, 100*0.7, 100*0.7);
    pg1.endDraw();

    pg2.beginDraw();
    pg2.background(0);
    pg2.fill(255, 255, 255);
    pg2.shapeMode(CENTER);
    pg2.pushMatrix();
    pg2.translate(100/2, 100/2);
    pg2.scale(.01*100, .01*100);
    pg2.shape(metenoSvg[0], 0, 0);
    pg2.popMatrix();
    pg2.endDraw();

    pg1.mask(pg2);
  } //metenoMask_end

  int compareTo(Object o) {
    Meteno m = (Meteno) o;
    return size-m.size;
  }
}
