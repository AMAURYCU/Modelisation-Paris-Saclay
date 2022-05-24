WorkSpace workspace;

void setup(){
fullScreen(P3D);
this.workspace = new WorkSpace(SIZE);
smooth(8);
background(0x40);

//noLoop();
}

void draw(){
  camera(   0  , 2500, 1000,   0, 0, 0,    0, 0, -1   ); 

 workspace.update();



}
void keyPressed(){
  switch(key){
  case 'w':
  case'W':
  this.workspace.toggle();
  break;
  }
}
