public class Gpx{
PShape track;
PShape posts;
PShape thumbtack;

Gpx(Map3D map, String fileName){
  
File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 
 this.track = createShape();
 this.track.beginShape(LINE_STRIP);
 this.track.strokeWeight(3.0f);
 this.track.stroke(0xAAFF3F7F); 
 for(int f=0; f<features.size();f++){
 
   JSONObject feature = features.getJSONObject(f); 
   if (!feature.hasKey("geometry"))
   break;
   JSONObject geometry = feature.getJSONObject("geometry"); 
   switch (geometry.getString("type", "undefined")) { 
   
   case "LineString":
   JSONArray coordinates = geometry.getJSONArray("coordinates"); 
   if (coordinates != null) {
     for (int p=0; p < coordinates.size(); p++) {         JSONArray point = coordinates.getJSONArray(p);
      
   Map3D.GeoPoint o = map.new GeoPoint(point.getDouble(0),point.getDouble(1));
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
   this.track.vertex(o2.x,o2.y,o2.z);
   }}}
   break;
   
   
   }
 
 
 
 
   this.track.endShape();
 this.posts = createShape();
 this.posts.beginShape(LINES);
  this.posts.strokeWeight(2.0f);
 this.posts.stroke(#EBEDED); 
 for (int f=0; f<features.size(); f++) { 
 JSONObject feature = features.getJSONObject(f); 
 if (!feature.hasKey("geometry"))     break; 
 JSONObject geometry = feature.getJSONObject("geometry");
  switch (geometry.getString("type", "undefined")) { 
  
  case"Point":
  if (geometry.hasKey("coordinates")) {
  JSONArray point = geometry.getJSONArray("coordinates");       
  String description = "Pas d'information.";
  if (feature.hasKey("properties")) {         description = feature.getJSONObject("properties").getString("desc", description);       }
  Map3D.GeoPoint o= map.new  GeoPoint(point.getDouble(0),point.getDouble(1));
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
   this.posts.vertex(o2.x,o2.y,o2.z);
   this.posts.vertex(o2.x,o2.y,o2.z+50);
  
  
  }
  
  
  }
 
 }
 this.posts.endShape();
 
 
 
 this.thumbtack = createShape();
 this.thumbtack.beginShape(POINTS);
  this.thumbtack.strokeWeight(12.0f);
 this.thumbtack.stroke(0xFFFF3F3F); 
 for (int f=0; f<features.size(); f++) { 
 JSONObject feature = features.getJSONObject(f); 
 if (!feature.hasKey("geometry"))     break; 
 JSONObject geometry = feature.getJSONObject("geometry");
  switch (geometry.getString("type", "undefined")) { 
  
  case"Point":
  if (geometry.hasKey("coordinates")) {
  JSONArray point = geometry.getJSONArray("coordinates");       
  String description = "Pas d'information.";
  if (feature.hasKey("properties")) {         description = feature.getJSONObject("properties").getString("desc", description);       }
  Map3D.GeoPoint o= map.new  GeoPoint(point.getDouble(0),point.getDouble(1));
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
   
   this.thumbtack.vertex(o2.x,o2.y,o2.z+50+5.0f);
  
  
  }
  
  
  }
 
 }
 this.thumbtack.endShape();
 
 
}
void clic(float x, float y,Camera camera,String fileName){
for(int v = 0; v< this.thumbtack.getVertexCount(); v++){
  PVector hit = this.thumbtack.getVertex(v);

  if(dist(x,y,screenX(hit.x,hit.y,hit.z),screenY(hit.x,hit.y,hit.z))<10){
    this.thumbtack.setStroke(v,0xFF3FFF7F);
    afficheDescription(hit,camera,fileName);
  }
  else{this.thumbtack.setStroke(v,0xFFFF3F3F);}

}


}

void afficheDescription(PVector hit,Camera camera,String fileName){
  //charger le fichier JSON dans cette fonction dans la fonction précédente appeler cette fonction lors d'un clic 
  //cette fonction parcours tout les points pour savoir si on affiche la description ou pas
  String s = "";
   File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 
     for (int f=0; f<features.size(); f++) { 
 JSONObject feature = features.getJSONObject(f); 
 if (!feature.hasKey("geometry"))     break; 
 JSONObject geometry = feature.getJSONObject("geometry");
  switch (geometry.getString("type", "undefined")) { 
  
  case"Point":
  if (geometry.hasKey("coordinates")) {
  JSONArray point = geometry.getJSONArray("coordinates");       
  String description = "Pas d'information.";
  if (feature.hasKey("properties")) {         description = feature.getJSONObject("properties").getString("desc", description);       }
  Map3D.GeoPoint o= map.new  GeoPoint(point.getDouble(0),point.getDouble(1));
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
   if(o2.x == hit.x && o2.y == hit.y){
  
 s = description;
  
   


  }

  
  }
  
break; }
 
   
    
    
  }
  pushMatrix();
    lights();
    fill(0xFFFFFFFF); 
    translate(hit.x, hit.y, hit.z + 10.0f); 
    rotateZ(-camera.longitude-HALF_PI); 
    rotateX(-camera.colatitude);
    g.hint(PConstants.DISABLE_DEPTH_TEST); 
    textMode(SHAPE); 
    textSize(48); textAlign(LEFT, CENTER);
    
    text(s, 0, 0); 
   g.hint(PConstants.ENABLE_DEPTH_TEST); 
   popMatrix(); 


}

void update(){
shape(posts);
shape(thumbtack);
shape(track);
}
void toogle(){
posts.setVisible(!posts.isVisible());
thumbtack.setVisible(!thumbtack.isVisible());
track.setVisible(!track.isVisible());

}




}



  

  
