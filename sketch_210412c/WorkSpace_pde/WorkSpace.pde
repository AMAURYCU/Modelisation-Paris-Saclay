int SIZE =100;
public class WorkSpace{      
  PShape gizmo, grid;
  WorkSpace(int size){
    this.gizmo = createShape();
this.gizmo.beginShape(LINES);
this.gizmo.noFill();
this.gizmo.strokeWeight(3.0f);
//Red X
this.gizmo.stroke(0xAAFF3F7F); 

this.gizmo.vertex(0,0,0);
this.gizmo.vertex(100,0,0);//x
//Green Y
this.gizmo.stroke(0xAA3FFF7F);
this.gizmo.vertex(0,0,0);
this.gizmo.vertex(0,100,0);//y
//Blue z
this.gizmo.stroke(0xAA3F7FFF); 
this.gizmo.vertex(0,0,0);
this.gizmo.vertex(0,0,100);//z
gizmo.strokeWeight(0.5f);
gizmo.stroke(#FA0505);
gizmo.vertex(-SIZE*100,0,0);
gizmo.vertex(SIZE*100,0,0);
gizmo.stroke(#24FA05);
gizmo.vertex(0,-SIZE*100,0);
gizmo.vertex(0,SIZE*100,0);
this.gizmo.endShape();
//gizmo.setVisible(false);
grid= createShape();
grid.beginShape(QUADS);
grid.noFill();
grid.stroke(0x77836C3D);
grid.strokeWeight(0.5f);


for(int i=-(size/2);i<=(size/2);i++){
  for(int j = -(size/2); j<=(size/2);j++){
    grid.vertex(i*100,j*100,0);
    grid.vertex((i+1)*100,j*100,0);
    grid.vertex((i+1)*100,(j+1)*100,0);
    grid.vertex(i*100,(j+1)*100,0);
    
    
  }
  
}
grid.endShape();


  }
  void update(){
    
      shape(grid);
      
  shape(this.gizmo);}
  
  
  void toggle(){
  this.gizmo.setVisible(!this.gizmo.isVisible());
 
 this.grid.setVisible(!this.grid.isVisible());
  clear();
  background(0x40);
  
}}
