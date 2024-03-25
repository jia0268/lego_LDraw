float s = 80;
size(500,500,P3D);
translate(width/2,height/2);
rotateX(radians(90));
String [] lines = loadStrings("4-4edge.dat");
for(String line : lines){
  String [] a =split(line, " ");
  if(a[0].equals("2")){
    beginShape(LINES);
    for(int i=0;i<2;i++){
      PVector p = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]));
      vertex(p.x*s,p.y*s,p.z*s);
    }
    endShape();
  }
}
