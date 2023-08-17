// 큰 물고기
class Big extends Sea {
  int cooltime;
  int segAmount=10;//물고기 분절 개수
  int segLength = 5; //물고기 길이

  PVector[] sPos = new PVector[segAmount];

  Big(float x, float y) { //생성자
    super(x, y);
    velVal = 1.2;
    opponentVel = 1.2;
    c = color(255, 111, 131, 255);
    for (int i=0; i<segAmount; i++) {
      sPos[i]=new PVector(i, i);
    }
  }

  void drawBig() { //물고기 화면에 그리기
    dead();
    eatTrash(trash, smalls);
    infection();
    border();
    fill(c);

    dragSegment(0, pos);
    for (int i=0; i<sPos.length-1; i++) {
      dragSegment(i+1, sPos[i]);
    }
    if(velVal < 0 && opponentVel <0.02 && alpha(c)>0){
      c = color(red(c), green(c), blue(c), alpha(c)-1);
    }
    
  }
  
    void dragSegment(int i, PVector pos) { //물고기 형태 그리기
    float aangle=atan2(pos.y-sPos[i].y, pos.x-sPos[i].x);
    sPos[i].x=pos.x-cos(aangle)*segLength;
    sPos[i].y=pos.y-sin(aangle)*segLength;

    pushMatrix();
    translate(sPos[i].x, sPos[i].y);
    rotate(aangle);
    noStroke();
    if (i==sPos.length-1) { //물고기 꼬리
      beginShape();
      vertex(5, 0);
      vertex(-10, -10);
      vertex(-10, 10);
      endShape();
    } else ellipse(0, 0, 20-i*2, 20-i*2); //몸통
    popMatrix();
  }
  
  void eatTrash(ArrayList<Trash> trash, ArrayList<Sea> opponent){ //가까운 먹이 찾기 메소드 오버라이딩
        float minDistTh=Float.MAX_VALUE;
        float minDistSea=Float.MAX_VALUE;
        int minTrash=0;
        int minSea = 0;
        
        for (int i=0;i<trash.size();++i){
            float dist=PVector.dist(pos, trash.get(i).pos);
            if (dist<minDistTh){
                minTrash=i;
                minDistTh=dist;
            }
        }
        
        for (int i=0;i<opponent.size();++i){
            float dist=PVector.dist(pos, opponent.get(i).pos);
            if (dist<minDistSea){
                minSea=i;
                minDistSea=dist;
            }
        }
        //감염된 물고기 먹기
        if(opponent.get(minSea).infect==true && minDistTh > minDistSea){
          if (minDistSea<100) {
              vel=PVector.sub(opponent.get(minSea).pos, pos);
              vel.normalize();//vel은 타겟을 향하는 크기 1 짜리 벡터
              vel.mult(opponentVel);
              pos.add(vel);
          
              if (this instanceof Big && minDistSea<5) {//5이하->살상범위
                opponent.remove(minSea);
                try{if(opponent.get(minSea).flag>1){
                  infect = true;
                }}catch(IndexOutOfBoundsException e){ System.out.println(e);}
              }
          } else {
            randomMovement();
          }
        }
        //쓰레기 먹기
        else{
          if (minDistTh<100) {
              vel=PVector.sub(trash.get(minTrash).pos, pos);
              vel.normalize();//vel은 타겟을 향하는 크기 1 짜리 벡터
              vel.mult(velVal);
              pos.add(vel);
          
              if (minDistTh<5) {//5이하->살상범위
                trash.remove(minTrash);
                infect = true;
              }
          } else {
            randomMovement();
          }
        }
    }
}
