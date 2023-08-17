// 쓰레기
class Trash {
  int margin=5;

  PVector pos; //위치
  PVector vel; //속도1
  PVector speed; //속도2
  float angle; //각도
  float velVal=1; //가속도
  int size; //크기

  Trash(float x, float y, int size) { //생성자
    pos=new PVector(x, y);
    vel=PVector.fromAngle(random(TWO_PI));
    vel.mult(velVal);
    angle=random(-0.1, 0.1);
    this.size = size;

    float startx = x + random(-5, 5);
    float starty = y + random(-5, 5);
    startx = constrain(startx, 0, width);
    starty = constrain(starty, 0, height);
    pos=new PVector(startx, starty);

    float xspeed = random(-2, 1);
    float yspeed = random(-2, 1);

    speed = new PVector(xspeed, yspeed);
  }

  void drawTrash() { //쓰레기 그리기
    spread();
    noFill();
    strokeWeight(2);
    stroke(100);
    ellipse(pos.x, pos.y, size, size);
  }

  void spread() { //쓰레기 퍼뜨리기
    pos.add(speed);//여러개가 여러 방향으로 퍼진다

    float damping = random(-0.5, -0.6); //border
    if (pos.x > width - margin || pos.x < margin) {
      speed.x *= damping;
    }
    if (pos.y > height -margin || pos.y < margin) {
      speed.y *= damping;
    }
  }
}
