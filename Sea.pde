//해양생물
class Sea {
  PVector vel; // 속도
  int flag = 1; //감염 인지
  color c; //색깔
  PVector pos; //위치
  float angle; //각도
  float velVal = 1;
  int isDie = 0;
  float opponentVel = 1.0;
  boolean infect = false;

  Sea(float x, float y) { //생성자
    pos = new PVector(x, y);
    //vel = PVector.fromAngle(random(TWO_PI));
    vel = new PVector(random(1), random(1));
    vel.mult(velVal);
    angle = random(-0.1, 0.1);
  }

  void border() {
    if (pos.x>width) vel.x *= -1;
    if (pos.x<0) vel.x *= -1;
    if (pos.y>height) pos.y *= -1;
    if (pos.y < 0) pos.y *=-1;
  }

  void drawBig() {
  };
  void drawSmall() {
  };
  void drawStarFish() {
  };
  void drawSeaCucumber() {
  };

  void randomMovement() {
    if (frameCount % 30 == 0) angle = random(-0.1, 0.1);
    vel.rotate(angle);
    pos.add(vel);
  }

  void eatTrash(ArrayList<Trash> trash) { //가까운 먹이 찾기
    float minDistTh=Float.MAX_VALUE;
    int minTrash=0;

    for (int i=0; i<trash.size(); ++i) {
      float dist=PVector.dist(pos, trash.get(i).pos);
      if (dist<minDistTh) {
        minTrash=i;
        minDistTh=dist;
      }
    }
    try {
      if (minDistTh<300) {
        vel=PVector.sub(trash.get(minTrash).pos, pos);
        vel.normalize();//vel은 타겟을 향하는 크기 1 짜리 벡터
        vel.mult(velVal);
        pos.add(vel);

        if (minDistTh<5) {//5이하->살상범위
          trash.remove(minTrash);
          infect = true;
          vel.mult(0);
        }
      } else {
        randomMovement();
      }
    }
    catch(IllegalArgumentException e) {
    }
  }

  void dead() { //감염횟수가 특정 수 이상일 경우 속도 저하
    if (flag % 40 == 0) {
      if (velVal > 0) velVal -= 0.02;
      if (this instanceof Big && opponentVel > 0.02) opponentVel -= 0.02;
      if (this instanceof Small && opponentVel < -0.02) opponentVel += 0.02;
      if (velVal < 0) vel.mult(velVal);
    }
  }

  void infection() { //감염 시 flag 수치 증가, 수치만큼 alpha값 하락
    if (infect) flag++;
    if (flag % 30 == 0 && velVal > 0.2) {
      colorMode(HSB);
      c=color(
        constrain(hue(c)+1, 0, 360)
        , constrain(saturation(c), 0, 200)
        , constrain(brightness(c)-0.8, 0, 200)
        , constrain(alpha(c), 0, 150)
        );
      colorMode(RGB);
    }
  }
}
