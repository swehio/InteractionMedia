// 작은물고기
class Small extends Sea {
  int cooltime = 400;

  int segAmount=5; //물고기 분절 개수
  int segLength = 3; //물고기 길이

  PVector[] sPos = new PVector[segAmount];

  Small(float x, float y) { //생성자
    super(x, y);
    velVal=1.0;
    opponentVel = -1.0;
    c= color(255, 225, 76, 255);
    for (int i=0; i<segAmount; i++) {
      sPos[i]=new PVector(i, i);
    }
  }

  void drawSmall() { //작은 물고기 그리기
    dead();
    eatTrash(trash);
    border();

    fill(c);

    dragSegment(0, pos);
    for (int i=0; i<sPos.length-1; i++) {
      dragSegment(i+1, sPos[i]);
    }
    infection();
    reproduce();

    if (velVal < 0 && opponentVel > -0.02&& alpha(c)>0) {
      c = color(red(c), green(c), blue(c), alpha(c)-1);
    }
  }

  void reproduce() { //돌연변이 생산
    int minSmall = 0;
    float minSmallDist = Float.MAX_VALUE;

    for (int i = 0; i < smalls.size(); i++) {

      if (i == smalls.indexOf(this)) continue;

      float dist = PVector.dist(pos, smalls.get(i).pos);

      if (dist < minSmallDist) {
        minSmall = i;
        minSmallDist = dist;
      }
    }

    if (minSmallDist < 10) {
      if (random(1) < 0.001 && cooltime<0 && smalls.size()<50) {
        Small aNewborn = new Small(pos.x, pos.y);

        Sea spouse = smalls.get(minSmall);

        if (flag > 2 || spouse.flag > 2) {
          colorMode(HSB);
          aNewborn.c=color(
            random(1) >0.5 ? hue(c) : hue(spouse.c)
            , saturation(c)
            , random(1)>0.5? brightness(c) : brightness(spouse.c)
            , alpha(c)
            );
          colorMode(RGB);
          aNewborn.flag = 2;
          aNewborn.infect = true;
        }

        smalls.add(aNewborn);
        cooltime = 400;
      }
    }
    cooltime--;
  }

  void dragSegment(int i, PVector pos) {
    float aangle=atan2(pos.y-sPos[i].y, pos.x-sPos[i].x);
    sPos[i].x=pos.x-cos(aangle)*segLength;
    sPos[i].y=pos.y-sin(aangle)*segLength;

    pushMatrix();
    translate(sPos[i].x, sPos[i].y);
    rotate(aangle);

    noStroke();
    if (i==sPos.length-1) { //꼬리
      beginShape();
      vertex(0, 0);
      vertex(-7, -7);
      vertex(-7, 7);
      endShape();
    } else if (i<sPos.length/3) ellipse(0, 0, 8+i, 8+i); //몸통 앞 부분
    else ellipse(0, 0, 13-i, 13-i); //몸통 뒷부분
    popMatrix();
  }
}
