
public class Camera{
  float radius;
  float colatitude;
  float longitude;
  float x;
  float y;
  float z;
  boolean lightning;
  float determineX(){
  return this.radius*sin(this.colatitude)*cos(this.longitude);
  }
  float determineY(){
  return this.radius*sin(this.longitude)*sin(this.colatitude);
  
  }
  float determineZ(){
  return this.radius*cos(this.colatitude);
  }
  Camera(){
  this.lightning = false;
  this.radius = 2500;
  this.colatitude = 1000%(PI/2);
  this.longitude = -PI/2;
  this.x = this.determineX();
  this.y = this.determineY();
  this.z = this.determineZ();
  }
  void update(){
   this.determineXYZ();
  // background(0x40);
  camera(this.x , -this.y, this.z,
  0,0,0,
  0,0,-1);
  
  ambientLight(0x7F,0x7F,0x7F);
  if(lightning)
   directionalLight(0xA0, 0xA0, 0x60, 0, 0, -1);
   lightFalloff(0.0f, 0.0f, 1.0f);
  lightSpecular(0.0f, 0.0f, 0.0f); 
  }
  
  
  void adjustRadius(float offset){
    if(offset+this.radius >width*0.5 && offset+this.radius <width*3.0){
  this.radius = this.radius+offset;
  this.determineXYZ();
  }}
  void adjustLongitude(float delta){
   if(this.longitude+delta > -3*PI/2.0 && this.longitude+delta<PI/2.0){
  this.longitude =this.longitude+ delta;
  }}
  void adjustColatitude(float delta){
    if(this.colatitude+delta>0.000001 && this.colatitude+delta<PI/2.0){
      print(10);
  this.colatitude = this.colatitude+delta;
  this.determineXYZ();
  print(10);
    }
    
  }
  void determineXYZ(){
  this.x=this.determineX();
  this.y=this.determineY();
  this.z=this.determineZ();}
  
  void toogle(){
  this.lightning = !this.lightning;
  }
}
