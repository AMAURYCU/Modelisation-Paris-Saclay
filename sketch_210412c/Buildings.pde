public class Buildings{
  PShape buildings;
  Map3D map;
Buildings(Map3D map){
  this.map = map;
 this.buildings = createShape(GROUP); 
 this.add("buildings_Paris_Saclay.geojson", 0xFFee00dd);
 this.add("buildings_city.geojson", 0xFFaaaaaa);   this.add("buildings_IPP.geojson", 0xFFCB9837);   this.add("buildings_EDF_Danone.geojson", 0xFF3030FF);   this.add("buildings_CEA_algorithmes.geojson", 0xFF30FF30);   this.add("buildings_Thales.geojson", 0xFFFF3030); 
}//fermeture constructeur

void addWalls(String fileName, color c){
PShape bat = createShape(GROUP);
File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 

 for(int f=0; f<features.size();f++){
 PShape walls = createShape();
  walls.beginShape(QUAD);

walls.stroke(c+0x30);

 walls.fill(c+0x60);
 walls.emissive(0x30);
     
  JSONObject feature = features.getJSONObject(f); 
  int levels = feature.getJSONObject("properties").getInt("building:levels", 1);
  float top =0;
  top += Map3D.heightScale*3.0f*(float)levels;
 if (!feature.hasKey("geometry"))
   break;
   JSONObject geometry = feature.getJSONObject("geometry"); 
   switch (geometry.getString("type", "undefined")) { 
   
   case "Polygon":
   JSONArray coordinates = geometry.getJSONArray("coordinates"); 
   
   if (coordinates != null) {
    for (int p=0; p < coordinates.size(); p++) {         
      JSONArray tab = coordinates.getJSONArray(p);
      JSONArray jsp = tab.getJSONArray(0);
      Map3D.GeoPoint gpna = map.new GeoPoint(jsp.getDouble(0),jsp.getDouble(1));
        Map3D.MapPoint mpna = map.new MapPoint(gpna);
         Map3D.ObjectPoint opna = map.new ObjectPoint(mpna);
          walls.normal(0,0,1);
         walls.vertex(opna.x,opna.y,opna.z);
          walls.normal(0,0,1);
         walls.vertex(opna.x,opna.y,opna.z+top);
      for(int d = 1; d<tab.size();d++){
        JSONArray A = tab.getJSONArray(d);
       Map3D.GeoPoint gpa = map.new GeoPoint(A.getDouble(0),A.getDouble(1));
        Map3D.MapPoint mpa = map.new MapPoint(gpa);
         Map3D.ObjectPoint opa = map.new ObjectPoint(mpa);
         if(!opa.inside()) break;
         walls.normal(0,0,1);
         walls.vertex(opa.x,opa.y,opa.z+top);
       walls.normal(0,0,1);
         walls.vertex(opa.x,opa.y,opa.z);
          walls.normal(0,0,1);
     walls.vertex(opa.x,opa.y,opa.z);
     walls.normal(0,0,1);
       walls.vertex(opa.x,opa.y,opa.z+top);
        }
         
  

}//fermeture for

   walls.endShape();

   
   
   }//fermeture if
   
 
 }//fermeture switch
 bat.addChild(walls);
 
 }//fermeture for feature

buildings.addChild(bat);

}//fermeture add









void addRoof(String fileName, color c){

PShape bat = createShape(GROUP);
File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 

 for(int f=0; f<features.size();f++){
 PShape roof = createShape();
  roof.beginShape(POLYGON);
   
roof.stroke(c);

 roof.fill(c+0x30); 
 roof.emissive(0x100);
  JSONObject feature = features.getJSONObject(f); 
  int levels = feature.getJSONObject("properties").getInt("building:levels", 1);
  float top =0;
  top += Map3D.heightScale*3.0f*(float)levels;
 if (!feature.hasKey("geometry"))
   break;
   JSONObject geometry = feature.getJSONObject("geometry"); 
   switch (geometry.getString("type", "undefined")) { 
   
   case "Polygon":
   JSONArray coordinates = geometry.getJSONArray("coordinates"); 
   
   if (coordinates != null) {
    for (int p=0; p < coordinates.size(); p++) {         
      JSONArray tab = coordinates.getJSONArray(p);
      for(int d = 0; d<tab.size();d++){
        JSONArray A = tab.getJSONArray(d);
       Map3D.GeoPoint gpa = map.new GeoPoint(A.getDouble(0),A.getDouble(1));
        Map3D.MapPoint mpa = map.new MapPoint(gpa);
         Map3D.ObjectPoint opa = map.new ObjectPoint(mpa);
         if(!opa.inside()) break;
         roof.emissive(0x70);
         roof.normal(0,0,1);
         roof.vertex(opa.x,opa.y,opa.z+top);}
          JSONArray A = tab.getJSONArray(tab.size()-1);
       Map3D.GeoPoint gpa = map.new GeoPoint(A.getDouble(0),A.getDouble(1));
        Map3D.MapPoint mpa = map.new MapPoint(gpa);
         Map3D.ObjectPoint opa = map.new ObjectPoint(mpa);
         roof.normal(0,0,1);
         roof.vertex(opa.x,opa.y,opa.z+top);

         
         
  

}//fermeture for

   roof.endShape();
  
   
   
   }//fermeture if
   
 
 }//fermeture switch
 bat.addChild(roof);
 
 }//fermeture for feature

buildings.addChild(bat);

}











void add(String fileName, color c){
 addWalls(fileName,c);
 addRoof(fileName,c);


}


void update(){
shape( buildings);
}
void toggle(){
buildings.setVisible(!buildings.isVisible());
}





}//fermeture calsse
