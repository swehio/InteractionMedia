int click_count; //클릭 횟수
color water_c=color(36, 164, 223);
boolean water_call= true;
boolean throwTrash = false;
int MAX=10; // 쓰레기 수

ArrayList<Trash> garbage = new ArrayList<Trash>(); //쓰레기 객체 배열 생성
ArrayList<Trash> trash = new ArrayList<Trash>();
ArrayList<Sea> smalls=new ArrayList<Sea>(); //물고기 객체 배열 생성
ArrayList<Sea> bigs=new ArrayList<Sea>();
ArrayList<Sea> starFish=new ArrayList<Sea>(); //해,불 객체 배열 생성
ArrayList<Sea> seaCucumber=new ArrayList<Sea>();
ArrayList<Ripple_wave> r = new ArrayList<Ripple_wave>(); // 물 파동 배열 생성

void setup() {
  size(1000, 600, P2D);

  rectMode(CENTER);

  for (int i=0; i< 30; ++i) {
    smalls.add(new Small(random(width), random(height)));
  }

  for (int i=0; i< 5; ++i) {
    bigs.add(new Big(random(width), random(height)));
  }

  for (int i=0; i< 2; ++i) {
    starFish.add(new Cleaner(random(width), random(height)));
  }
  for (int i=0; i< 2; ++i) {
    seaCucumber.add(new Cleaner(random(width), random(height)));
  }
}

void draw() {
  background(water_c); //물 색
  int iteratorSize = r.size(); // 물 파동 변수

  pollution();

  //해양생물 그리기(큰 물고기, 작은 물고기, 불가사리, 해삼)
  for (int i = 0; i< bigs.size(); i++) {
    bigs.get(i).drawBig();
  }
  for (int i = 0; i < smalls.size(); i++) {
    smalls.get(i).drawSmall();
  }

  for (int i = 0; i < starFish.size(); i++) {
    starFish.get(i).drawStarFish();
  }

  for (int i = 0; i < seaCucumber.size(); i++) {
    seaCucumber.get(i).drawSeaCucumber();
  }

  // 클릭 시 쓰레기 그리기
  if (throwTrash == true) {
    for (int i = 0; i < trash.size(); i++) {
      trash.get(i).drawTrash();
    }
  }

  //클릭 수 일정 이상일 경우 쓰레기 그리기
  if (click_count > 5) {
    for (int i = 0; i < garbage.size(); i++) {
      garbage.get(i).drawTrash();
    }
  }

  //물 파동
  for (int i=0; i<iteratorSize; i++ ) {
    Ripple_wave eachRipple = r.get(i);
    eachRipple.display();
    eachRipple.grow();
  }
  for (int i=0; i<iteratorSize-1; i++ ) {
    Ripple_wave eachRipple = r.get(i);
    if (eachRipple.alpha < 0 ) {
      r.remove(eachRipple);
    }
  }

  //특정 알파값 이하이면 객체 삭제
  for (int i = 0; i<smalls.size(); i++) {
    if (alpha(smalls.get(i).c) < 50) {
      smalls.remove(i);
      print("smalls remove");
    }
  }
  for (int i = 0; i<bigs.size(); i++) {
    if (alpha(bigs.get(i).c) < 50) {
      bigs.remove(i);
      print("bigs remove");
    }
  }
  for (int i = 0; i<starFish.size(); i++) {
    if (alpha(starFish.get(i).c) < 50) {
      starFish.remove(i);
      print("starFish remove");
    }
  }
  for (int i = 0; i<seaCucumber.size(); i++) {
    if (alpha(seaCucumber.get(i).c) < 50) {
      seaCucumber.remove(i);
      print("starFish remove");
    }
  }
}

void mousePressed() {
  //trash.add(new Trash(mouseX, mouseY, 10));
  throwTrash = true;
  click_count++;

  //클릭  시 퍼지는 쓰레기 생성
  for (int i = 0; i < MAX; i ++) {
    trash.add(new Trash(mouseX, mouseY, 10));
    if (trash.size() > 5*MAX) {
      trash.remove(0);
    }
    throwTrash = true;
  }

  //click수가 일정 이상이면 떠다니는 쓰레기 생성1
  if (click_count>5 && garbage.size() < 8 || click_count%5==0) {
    for (int i = 0; i < 8; i++) {
      garbage.add(new Trash(random(width), random(height), int(random(20, 50))));
    }
  }

  //click수가 일정 이상이면 떠다니는 쓰레기 생성2
  if (click_count>8 && garbage.size() < 15 || click_count%8==0) {
    for (int i = 0; i < 15; i++) {
      garbage.add(new Trash(random(width), random(height), int(random(20, 50))));
    }
  }
   r.add(new Ripple_wave(mouseX, mouseY));
}

//클릭 시 물 파동
void mouseClicked() {
  //r.add(new Ripple_wave(mouseX, mouseY));
}

// 클릭 수가 일정 이상 넘어갈 경우 물이 오염된다.
void pollution() {
  colorMode(HSB);
  if (click_count > 4 && brightness(water_c) > 85) {
    water_c=color(
      constrain(hue(water_c), 0, 360)
      , constrain(saturation(water_c), 0, 100)
      , constrain(brightness(water_c)-0.5, 0, 100)
      );
  }
  if (click_count > 6 && brightness(water_c) > 60) {
    water_c=color(
      constrain(hue(water_c), 0, 360)
      , constrain(saturation(water_c), 0, 100)
      , constrain(brightness(water_c)-0.01, 0, 100)
      );
  }
  colorMode(RGB);
  water_call = false;
}
