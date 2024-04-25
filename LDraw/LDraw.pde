float s = 8;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
ArrayList<Integer> colors = new ArrayList<Integer>(); //改用正確的色碼(真的色彩)，直接放color色彩，不再放 code index
ArrayList<Integer> current_color = new ArrayList<Integer>(); //現在的色彩
ArrayList<Integer> complement_color = new ArrayList<Integer>(); //現在色彩對應的互補色
color [] table = new color[256]; //現在顏色
color [] table2 = new color[256]; //互補色
String[] myLoadStrings(String filename){
  File file = new File(dataPath(filename));
  if(!file.exists()) return null;
  else return loadStrings(filename);
}
void myReadDat(String filename){
  String filename2 = "";
  for(int i=0; i<filename.length(); i++){
    if(filename.charAt(i)=='\\')filename2 += '/';
    else filename2 += filename.charAt(i);
  }
  String [] lines = myLoadStrings("parts/"+filename2);
  //if(lines==null) lines = myLoadStrings("p/48/"+filename2);
  if(lines==null) lines = myLoadStrings("p/"+filename2);
  if(lines==null) lines = myLoadStrings("models/"+filename2);
  for(String line : lines){
    String [] a =split(line, " ");
    if(a[0].equals("2")||a[0].equals("3")||a[0].equals("4")||a[0].equals("5")){
      int ptN = int(a[0]);
      PVector [] pt = new PVector[ptN];
      for(int i=0;i<ptN;i++){
        if(ptN==5 && i==4){ //特別針對輔助線 Type 5其實只有4個頂點
          pt[i] = new PVector(); //無用的點 
        }else{ //有用的點
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]));
        }
      }
      pts.add(pt);
      if(int(a[1])==16){ //主要色
        colors.add(current_color.get(current_color.size()-1));
      }else if(int(a[1])==24){ //輔助色
        colors.add(complement_color.get(complement_color.size()-1));
      }
      else colors.add(table[int(a[1])]); //改用正確的色碼(真的色彩)，直接放color色彩，不再放 code index
    }else if(a[0].equals("1")){
      float [] m = new float[12];
      for(int i=0;i<12;i++) m[i] = float(a[2+i]);
      int prev = pts.size(); //讀入更多檔案之前
      if(int(a[1])==16){
        current_color.add(current_color.get(current_color.size()-1));
        complement_color.add(complement_color.get(complement_color.size()-1));
      }else{
        current_color.add(table[int(a[1])]); //push顏色
        complement_color.add(table[int(a[1])]);
      }
      myReadDat(a[14]); //讀入新檔案
      current_color.remove(current_color.size()-1); //pop顏色
      complement_color.remove(complement_color.size()-1); 
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
  current_color.add(#FFFF80);
  complement_color.add(#333333);
  table[0] = #000000;
  table[16] = #FFFF80;
  table[24] = #7F7F7F;
  table[32] = #000000;
  table2[0] = #333333;
  table2[16] = #333333;
  table2[24] = #333333;
  table2[32] = #333333;
  myReadDat("3626cp01.dat");
}
void mouseDragged(){
  rotY += mouseX-pmouseX;
  rotX -= mouseY-pmouseY;
}
float rotX = 0,rotY = 180;
void draw(){
  lights();
  background(250);
  translate(width/2,height/2);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  for(int i=0; i<pts.size(); i++){
  //for(PVector [] pt : pts){
    PVector[] pt = pts.get(i);
    color c = colors.get(i);
    if(pt.length==2){
      beginShape(LINES);
      stroke(c);//改用正確的色碼(真的色彩)，直接放color色彩，不再放 code index
    }else if(pt.length==3 || pt.length==4){
      beginShape();
      noStroke();
      fill(c);
    }
    for(PVector p : pt){
      vertex(p.x*s,p.y*s,p.z*s);
    }
    if(pt.length==2)endShape();
    else if(pt.length==3 || pt.length==4)endShape(CLOSE);
  }
  //想要畫Line Type 5
  for(int i=0; i<pts.size(); i++){
    PVector[] pt = pts.get(i);
    color c = colors.get(i);
    if(pt.length==5){ //Type 5只有前四個有效頂點 點1 點2 輔助1 輔助2
      beginShape(LINES);
      stroke(c);
      for(int k=0;k<2;k++){ //只有前面兩個頂點要畫
        PVector p = pt[k];
        vertex(p.x*s,p.y*s,p.z*s);
      }
      endShape();
    }
  }
}
