#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

smooth in vec4 vertColor;
smooth in vec4 vertTexCoord;
smooth in vec2 vertHeat;

void main() {
  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;
  float red = gl_FragColor.r;
  if(vertHeat[0]<100.0){
    if(( -1.0/100)*vertHeat[0]+1<red){
      gl_FragColor.r = red;}
      else{
    gl_FragColor.r =( -1.0/100)*vertHeat[0]+1;}
  
  }
float blue = gl_FragColor.g;
  if(vertHeat[1]<100.0){
    if(( -1.0/100)*vertHeat[1]+1<blue){
      gl_FragColor.g = blue;}
      else{
    gl_FragColor.g =( -1.0/100)*vertHeat[1]+1;}
  

}}
