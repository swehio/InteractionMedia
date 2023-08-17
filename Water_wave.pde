class Ripple_wave { // 물의 파동
  PVector pos;
  float scale;
  float scale2;
  float scale3;
  float alpha;
  float alpha2;
  float alpha3;

  Ripple_wave(float x, float y) { // 생성자
    pos = new PVector(x, y);
    scale = 0;
    scale2 = 0;
    scale3 = 0;
    alpha = 255;
    alpha2 = 255;
    alpha3 = 255;
  }

  void display() { //물 표시
    strokeWeight(4); // 파동의 두께
    noFill();
    stroke(255, alpha);
    ellipse(pos.x, pos.y, scale, scale);
    stroke(255, alpha2);
    ellipse(pos.x, pos.y, scale2, scale2);
    stroke(255, alpha3);
    ellipse(pos.x, pos.y, scale3, scale3);
  }

  void grow() //커지는 물 파동
  {
    scale += 0.8;
    scale2 += 1.2;
    scale3 +=1.5;
    alpha-= 1.2;
    alpha2-=1.4;
    alpha3-=1.8;
  }
}
