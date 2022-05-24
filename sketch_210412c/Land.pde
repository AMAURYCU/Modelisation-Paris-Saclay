public class Land{
PShape shadow;
PShape wireFrame;
PShape satellite;

Map3D map;
Points bench;
Points PicNic;
Land(Map3D map,String nomFichier,String fileName,String fileNamebis){
final float tileSize = 25.0f;
this.map = map;
bench= new Points(fileName);
PicNic = new Points(fileNamebis);
float w = (float)Map3D.width;
float h= (float) Map3D.height;
this.shadow = createShape();
this.shadow.beginShape(QUADS);
this.shadow.fill(0x992F2F2F);
this.shadow.noStroke();
Map3D.ObjectPoint osw= this.map.new ObjectPoint(-w/2.0f, +h/2.0f); 
Map3D.ObjectPoint one = this.map.new ObjectPoint(+w/2.0f, -h/2.0f);
Map3D.ObjectPoint ose= this.map.new ObjectPoint(-w/2.0f, -h/2.0f); 
Map3D.ObjectPoint onw= this.map.new ObjectPoint(+w/2.0f, +h/2.0f); 
shadow.vertex(osw.x,osw.y,-10);
shadow.vertex(ose.x,ose.y,-10);
shadow.vertex(one.x,one.y,-10);
shadow.vertex(onw.x,onw.y,-10);
this.shadow.endShape();
wireFrame= createShape();
wireFrame.beginShape(QUADS);
wireFrame.noFill();
wireFrame.stroke(#888888);
wireFrame.strokeWeight(0.5f);

for(float i=-h/2.0f;i<h/2.0f;i=i+tileSize){
  for(float j= -w/2.0f;j<w/2.0f; j=j+tileSize){
    Map3D.ObjectPoint a = this.map.new ObjectPoint(j,i);
    Map3D.ObjectPoint b = this.map.new ObjectPoint(j,i+tileSize);
    Map3D.ObjectPoint c= this.map.new ObjectPoint(j+tileSize,i+tileSize);
    Map3D.ObjectPoint d = this.map.new ObjectPoint(j+tileSize,i);
    this.wireFrame.vertex(a.x,a.y,a.z);
    this.wireFrame.vertex(b.x,b.y,b.z);
    this.wireFrame.vertex(c.x,c.y,c.z);
    this.wireFrame.vertex(d.x,d.y,d.z);
   
    
    
  
  }}
   this.wireFrame.endShape();
 PImage uvmap = loadImage(nomFichier); 
 float newU = uvmap.width/w;
float newV = uvmap.height/h;
 satellite= createShape();
 this.satellite.setTextureMode(IMAGE);
satellite.beginShape(QUADS);

this.satellite.texture(uvmap);
satellite.noFill();
satellite.noStroke();
   File ressource = dataFile(nomFichier);
if (!ressource.exists() || ressource.isDirectory()){
  println("ERROR: Land texture file " + nomFichier + " not found.");
  exitActual();
}

this.satellite.emissive(0xD0);


    
for(float i=-h/2.0f, v= 0;i<h/2.0f;i=i+tileSize, v=v+ tileSize){
  for(float j= -w/2.0f, u = 0;j<w/2.0f; j=j+tileSize, u = u+ tileSize){
    Map3D.ObjectPoint a = this.map.new ObjectPoint(j,i);
    PVector an = a.toNormal();
    Map3D.ObjectPoint b = this.map.new ObjectPoint(j+tileSize,i);
    PVector bn= b.toNormal();
    Map3D.ObjectPoint c= this.map.new ObjectPoint(j+tileSize,i+tileSize);
    PVector cn = c.toNormal();
    Map3D.ObjectPoint d = this.map.new ObjectPoint(j,i+tileSize);
    PVector dn = d.toNormal();
    
    this.satellite.normal(an.x,an.y,an.z);
    PVector v2 = new PVector(a.x,a.y,a.z);
   this.satellite.attrib("heat",distance( v2,this.bench),distance(v2,this.PicNic));
    this.satellite.vertex(a.x,a.y,a.z,u*newU,v*newV);
    this.satellite.normal(bn.x,bn.y,bn.z);
    v2= new PVector(b.x,b.y,b.z);
     this.satellite.attrib("heat",distance(v2,this.bench),distance(v2,this.PicNic));
    this.satellite.vertex(b.x,b.y,b.z,(u+tileSize)*newU,v*newV);
    
    this.satellite.normal(cn.x,cn.y,cn.z);
     v2= new PVector(c.x,c.y,c.z);
     this.satellite.attrib("heat",distance(v2,this.bench),distance(v2,this.PicNic));
    this.satellite.vertex(c.x,c.y,c.z,(u+tileSize)*newU,(v+tileSize)*newV);
    this.satellite.normal(dn.x,dn.y,dn.z);
    v2= new PVector(d.x,d.y,d.z);
     this.satellite.attrib("heat",distance( v2,this.bench),distance(v2,this.PicNic));
    this.satellite.vertex(d.x,d.y,d.z,u*newU,(v+tileSize)*newV);


    
  
  }}
  this.satellite.endShape();

  
  
  
  
 
  this.shadow.setVisible(true);
  this.wireFrame.setVisible(false);
  this.satellite.setVisible(true);

}
void update(){

shape(this.shadow);
shape(this.wireFrame);
shader(shader);

shape(this.satellite);


}
void toogle(){
//this.shadow.setVisible(!this.shadow.isVisible());
this.wireFrame.setVisible(!this.wireFrame.isVisible());
this.satellite.setVisible(!this.satellite.isVisible());
}

float distance(PVector pv,Points p){
  float dist = 500000;
for(int k =0; k<p.c-1;k++){
  

if(dist > dist(pv.x,pv.y,pv.z,(float)p.tabP[k].x,(float)p.tabP[k].y,(float)p.tabP[k].z)){
  dist = dist(pv.x,pv.y,pv.z,(float)p.tabP[k].x,(float)p.tabP[k].y,(float)p.tabP[k].z);
  //println(dist);
}

}
  return dist;
}

//void distanceTP(){
//satellite.attrib
//for(int k= 0; k<satellite.getVertexCount();k++){
 
//this.satellite.setAttrib("heat", k, (float)distance(k,this.bench),(float)distance(k,this.PicNic));
//println(k);
//}



//}

}
