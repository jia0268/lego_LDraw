float s = 8;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
void myReadDat(String filename){
  String filename2 = "";
  for(int i=0; i<filename.length(); i++){
    if(filename.charAt(i)=='\\')filename2 += '/';
    else filename2 += filename.charAt(i);
  }
  String [] lines = loadStrings(filename2);
  for(String line : lines){
    String [] a =split(line, " ");
    if(a[0].equals("2")||a[0].equals("3")||a[0].equals("4")){
      PVector [] pt = new PVector[int(a[0])];
      for(int i=0;i<int(a[0]);i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]));
      }
      pts.add(pt);
    }else if(a[0].equals("1")){
      float [] m = new float[12];
      for(int i=0;i<12;i++) m[i] = float(a[2+i]);
      int prev = pts.size(); //讀入更多檔案之前
      myReadDat(a[14]); //讀入新檔案
      int after = pts.size(); //讀入更多檔案之後
      for(int i=prev;i<after;i++){
        PVector [] now = pts.get(i);
        for(PVector p : now){
          float x2 = m[3]*p.x + m[4]*p.y + m[5]*p.z + m[0];
          float y2 = m[6]*p.x + m[7]*p.y + m[8]*p.z + m[1];
          float z2 = m[9]*p.x + m[10]*p.y + m[11]*p.z + m[2];
          p.x = x2;
          p.y = y2;
          p.z = z2;
        }
      }
    }
  }
}
void setup(){
  size(500,500,P3D);
  myReadDat("3626cp01.dat");
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
