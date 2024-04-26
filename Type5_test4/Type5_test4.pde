//step04 在不懂的情況下 試看看線對不對//看不懂嗚嗚嗚嗚 
PVector [] p = new PVector[4];

void setup(){
  size(400,400,P3D);
  p[0] = new PVector(200,0);
  p[1] = new PVector(200,200);
  p[2] = new PVector(300,100);
  p[3] = new PVector(0,0);
}
void draw(){
  background(#AAAAAA);
  for(int i=0;i<4;i++){
    ellipse(p[i].x,p[i].y,20,20);
  }
}
void mousePressed(){ //再印一次以確認預設值是對的
  
  PGraphics3D g = (PGraphics3D) this.g;
  
  g.projmodelview.print();//最重要
}
boolean checkType5(PVector [] p){ //input 必須是2D
  float x1=p[0].x,y1=p[0].y;
  float x2=p[1].x,y2=p[1].y;
  float a=-(y2-y1),b=(x2-x1),c=-y1*(x2-x1)+x1*(y2-y1);
  return (a*p[2].x+b*p[2].y+c)*(a*p[3].x+b*p[3].y+c)>=0;//代入方程式看是否同向
}
