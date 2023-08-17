// 해삼, 불가사리
class Cleaner extends Sea {
  Cleaner(float x, float y) {
    super(x, y);

    velVal = 0.3;
    vel = new PVector(0.3, 0.3);
  }

  void drawStarFish() { //불가사리 그리기
    eatTrash(garbage);
    border();
    c= color(137, 229, 255, 255);
    fill(c);
    star(pos.x, pos.y, 5, 18, 5); // 별모양 그리기
    infection();
  }

  void drawSeaCucumber() { //해삼  그리기
    eatTrash(garbage);
    border();
    c= color(255, 146, 39, 255);
    fill(c);
    ellipse(pos.x, pos.y, 10, 20);
    infection();
  }
  
  // 불가사리 별 그리기
  void star(float x, float y, float radius1, float radius2, int npoints) {
    // radius1 = 안쪽 꼭지점들의 기준이 될 원의 radius
    // radius2 = 바깥쪽 꼭지점들의 기준이 될 원의 radius

    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;

    beginShape(); // 모양 그리기 시작

    for (float a = 0; a< TWO_PI; a += angle) { // 각도에 맞게 별의 뾰족이 그려줌

      float sx = x + cos(a) * radius2;  //
      float sy = y + sin(a) * radius2;  //
      vertex(sx, sy); // 별의 바깥쪽 꼭지점들의 위치

      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy); // 별의 안쪽 꼭지점들의 위치
    }
    endShape(CLOSE); // 모양 그리기 끝
  }
}
