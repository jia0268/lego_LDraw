//step02 直線方程式 另外兩點為控制點 看是否同向
//兩點直線方程式 (y-y2)/ (y1-y2) = (x-x2)/ (x1-x2)
//變數在線上，兩端點是常數 (x1,y1),(x2,y2)
//(x,y)-(x1,y1)~=(x2,y2)-(x1,y1) 兩個小線段斜率相同
//(y-y1)/(x-x1)==(y2-y1)/(x2-x1)
//(y-y1)*(x2-x1)==(y2-y1)*(x-x1)==>ax+by+c=0
//(y-y1)*(x2-x1)-(y2-y1)*(x-x1)==0
//-(y2-y1)*x+(x2-x1)*y+-y1*(x2-x1)+x1*(y2-y1)==0
PVector [] p = new PVector[4];
boolean checkType5(PVector [] p){
  float x1=p[0].x,y1=p[0].y;
  float x2=p[1].x,y2=p[1].y;
  float a=-(y2-y1),b=(x2-x1),c=-y1*(x2-x1)+x1*(y2-y1);
  return (a*p[2].x+b*p[2].y+c)*(a*p[3].x+b*p[3].y+c)>=0;//代入方程式看是否同向
}
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
  if(checkType5(p))stroke(255,0,0);
  else stroke(200,200,200);
  line(p[0].x,p[0].y,p[1].x,p[1].y); 
}
