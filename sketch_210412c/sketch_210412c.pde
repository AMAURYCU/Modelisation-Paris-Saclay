WorkSpace workspace;
Camera c;
Hud hud;
Map3D map;
Land land;
Roads roads;
Buildings buildings;
Railways railways;
Points p;
Points d;
PShader shader;

float Xmouse= 0;
float Ymouse = 0;
boolean pressed = false;
Gpx gpx;
void setup(){
//size(800,800,P3D);
fullScreen(P3D);
shader = loadShader("EmmanuelFragment.glsl","Emmanuel.glsl");
this.hud = new Hud();

this.workspace = new WorkSpace(SIZE);
this.c= new Camera();
this.map = new Map3D("paris_saclay.data");
this.p = new Points("bench.geojson");
this.d = new Points("parking.geojson");
this.land = new Land (map,"paris_saclay.jpg","bench.geojson","parking.geojson");
this.gpx= new Gpx(this.map, "trail.geojson");
this.railways = new Railways(this.map,"railways.geojson");
this.roads = new Roads(this.map,"roads.geojson");
this.buildings = new Buildings(this.map);

smooth(8);
background(0x40);
hint(ENABLE_KEY_REPEAT);
//print(c.colatitude);

hud.update();
}

void draw(){
 camera(   0  , 2500, 1000,   0, 0, 0,    0, 0, -1   ); 
 c.update();
gpx.update();
 workspace.update();
 shader = loadShader("EmmanuelFragment.glsl","Emmanuel.glsl");

land.update();
resetShader();
if(pressed)
this.gpx.clic(Xmouse,Ymouse,this.c,"trail.geojson");

railways.update();
hud.update();
roads.update();
shape(this.buildings.buildings);
}
void keyPressed(){
  switch(key){
  case 'w':
  case'W':
  this.workspace.toggle();
  break;
  
  case'x':
  case 'X':
  this.land.toogle();
  
  break;
  case'l':
  case'L':
  this.c.toogle();
  this.c.update();
  break;
  case'c':
  case'C':
  this.gpx.toogle();
  this.gpx.update();
  break;
  case'r':
  case'R':
  this.railways.toggle();
  this.railways.update();
  this.roads.toggle();
  this.roads.update();
  break;
  case'b':
  case'B':
  this.buildings.toggle();
  this.buildings.update();
break;
}
  if(key ==CODED){
    switch (keyCode){
    case UP:
    c.adjustColatitude(-0.01);
    c.update();
    //clear();
    background(0x40);
 
    break;
    case DOWN:
    c.adjustColatitude(0.01);
    c.update();
    //clear();
    background(0x40);
    break;
    case LEFT:
    c.adjustLongitude(-0.01);
    c.update();
    //clear();
    background(0x40);
    break;
    case RIGHT:
    c.adjustLongitude(0.01);
    c.update();
    //clear();
    background(0x40);
    break;
    }}
    else{
    switch(key){
   case'+':
   c.adjustRadius(-10);
   c.update();
   //clear();
   background(0x40);
   break;
   case'-':
   c.adjustRadius(10);
   c.update();
   //clear();
   background(0X40);
    }}
    
    }
    void mouseDragged(){
    if(mouseButton == LEFT){
      float dx = mouseX - pmouseX;
      c.adjustLongitude(-(dx/100.0)%(PI/2.0));
      c.update();
   
    float dy = mouseY-pmouseY;
  c.adjustColatitude(-(dy/100.0)%(PI/2.0));
c.update();
//clear();
background(0x40);}
if(mouseButton == RIGHT){
  float dy = mouseY-pmouseY;
  c.adjustRadius(-dy);
  c.update();
  //clear();
  background(0x40);}
  
    
    
    }
void mousePressed(){
  pressed = true;
Xmouse = mouseX;
Ymouse = mouseY;

}
