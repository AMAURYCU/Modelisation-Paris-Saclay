class Hud{
  private PMatrix3D hud;

  Hud(){
  this.hud = g.getMatrix((PMatrix3D) null);
  
  }
  private void begin(){
  g.noLights();
  g.pushMatrix();
  g.hint(PConstants.DISABLE_DEPTH_TEST);
  g.resetMatrix();
  g.applyMatrix(this.hud);
  
  }
  private void end(){
  g.hint(PConstants.ENABLE_DEPTH_TEST);
  g.popMatrix();
  }
private void displayFPS(){
noStroke();
fill(96);
rectMode(CORNER);
rect(10,height-30,60,20,5,5,5,5);
fill(0xF0);
textMode(SHAPE);
textSize(14);
textAlign(CENTER,CENTER);
text(String.valueOf((int)frameRate) + " fps", 40, height-20); 
}
public void update(){
  this.begin();
  this.displayFPS();
  this.displayCamera(c);
  this.end();
  
  
}
public void displayCamera(Camera c){
noStroke();
fill(96);
rectMode(CORNER);
rect(0,0,200,150,5,5,5,5);
fill(0xF0);
textMode(SHAPE);
textSize(18);
textAlign(CENTER,CENTER);
text("Camera",100, 30);
textSize(14);
text(String.valueOf("Longitude"+"      " + c.longitude*180/PI+"°"),100,60);
text(String.valueOf("colatitude"+"      " + c.colatitude*180/PI+"°"),100,90);
text(String.valueOf("Radius"+"      "+c.radius+"m"),100,120);

}

}
