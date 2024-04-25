//兩點直線方程式 (y-y2)/ (y1-y2) = (x-x2)/ (x1-x2)
//變數在線上，兩端點是常數 (x1,y1),(x2,y2)
//兩個小線段斜率相同
PVector [] p = new PVector[4];
void setup(){
  size(500,500);
  p[0] = new PVector(250,50);
  p[1] = new PVector(250,450);
  p[2] = new PVector(450,100);
  p[3] = new PVector(0,0);
}
void draw(){
  p[3].x=mouseX;
  p[3].y=pmouseY;
  background(#AAAAAA);
  ellipse(p[2].x,p[2].y,20,20); //兩個點的移動點
  ellipse(p[3].x,p[3].y,20,20); //兩個點的固定點
  line(p[0].x,p[0].y,p[1].x,p[1].y); 
}
