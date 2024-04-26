//step03 2D變3D
//先了解matrix矩陣;modelview矩陣 不用再管camera矩陣 因為他只受camera()影響
//modelview 矩陣 減一半 所以正中心的點會得到0
// x*1 再減一半 y*1 再減一半 z*1 再減sqrt3根號三
PVector [] p = new PVector[4];

void setup(){
  size(500,500,P3D);
  p[0] = new PVector(250,50);
  p[1] = new PVector(250,450);
  p[2] = new PVector(450,100);
  p[3] = new PVector(0,0);
  PGraphics3D g = (PGraphics3D) this.g;
  //g.modelview.print();
  //g.camera.print();//都不做任何 translate() rotate scale()時 camera==modelview
  g.projection.print();//預設矩陣
  //x*sqrt3 y*sqrt3 z*1.0202??
  //和視窗長寬有關係
}
void draw(){
  background(#AAAAAA);
}
void mousePressed(){ //再印一次以確認預設值是對的
  //https://processing.org/reference/perspective_.html
  //perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0)
  // where cameraZ is ((height/2.0) / tan(PI*60.0/360.0))
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0);
  //張角60度，長寬比，進的，遠的
  PGraphics3D g = (PGraphics3D) this.g;
  
  g.projmodelview.print();//最重要
}
boolean checkType5(PVector [] p){
  float x1=p[0].x,y1=p[0].y;
  float x2=p[1].x,y2=p[1].y;
  float a=-(y2-y1),b=(x2-x1),c=-y1*(x2-x1)+x1*(y2-y1);
  return (a*p[2].x+b*p[2].y+c)*(a*p[3].x+b*p[3].y+c)>=0;//代入方程式看是否同向
}
