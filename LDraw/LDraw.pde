float s = 80;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
void myReadDat(String filename){
  String [] lines = loadStrings(filename);
  for(String line : lines){
    String [] a =split(line, " ");
    if(a[0].equals("2")||a[0].equals("3")||a[0].equals("4")){
      PVector [] pt = new PVector[int(a[0])];
      for(int i=0;i<int(a[0]);i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]));
      }
      pts.add(pt);
    }
  }
}
void setup(){
  size(500,500,P3D);
  myReadDat("4-4cyli.dat");
  myReadDat("4-4edge.dat");
  myReadDat("4-4disc.dat");
}
void draw(){
  background(250);
  translate(width/2,height/2);
  rotateX(radians(frameCount));
  for(PVector [] pt : pts){
    if(pt.length==2)beginShape(LINE);
    else if(pt.length==3 || pt.length==4)beginShape();
    for(PVector p : pt){
      vertex(p.x*s,p.y*s,p.z*s);
    }
    if(pt.length==2)endShape();
    else if(pt.length==3 || pt.length==4)endShape(CLOSE);
  }
}
