public class Railways{
  PShape railways;
Railways(Map3D map,String fileName){

this.railways = createShape(GROUP);
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
   
 PShape a = createShape();
 a.beginShape(QUAD_STRIP);
a.strokeWeight(2.0f);
 a.stroke(#E5E1E1); 
   JSONObject feature = features.getJSONObject(f); 
   if (!feature.hasKey("geometry"))
   break;
   JSONObject geometry = feature.getJSONObject("geometry"); 
   switch (geometry.getString("type", "undefined")) { 
   
   case "LineString":
   JSONArray coordinates = geometry.getJSONArray("coordinates"); 
   if (coordinates != null) {
     JSONArray A = coordinates.getJSONArray(0);
     JSONArray B = coordinates.getJSONArray(1);
     JSONArray C = coordinates.getJSONArray(coordinates.size()-1);
     Map3D.GeoPoint gpa = map.new GeoPoint(A.getDouble(0),A.getDouble(1));
     Map3D.GeoPoint gpb = map.new GeoPoint(B.getDouble(0),B.getDouble(1));
     Map3D.GeoPoint gpc = map.new GeoPoint(C.getDouble(0),C.getDouble(1));
     Map3D.MapPoint mpa = map.new MapPoint(gpa);
     Map3D.MapPoint mpb = map.new MapPoint(gpb);
     Map3D.MapPoint mpc = map.new MapPoint(gpc);
     Map3D.ObjectPoint opa = map.new ObjectPoint(mpa);
     Map3D.ObjectPoint opb = map.new ObjectPoint(mpb);
     Map3D.ObjectPoint opc = map.new ObjectPoint(mpc);
     PVector vecA = new PVector(opa.x,opa.y,opa.z);
     PVector vecB = new PVector(opb.x,opb.y,opb.z);
     PVector vecC = new PVector(opc.x,opc.y,opc.z);
     PVector vecAB = new PVector(vecA.y -vecB.y,vecB.x - vecA.x).normalize().mult(10/2.0f);
     PVector vecAC = new PVector(vecC.x-vecA.x,vecC.y-vecA.y);
     a.normal(0.0f,0.0f,1.0f);
     a.vertex(vecA.x-vecAB.x,vecA.y-vecAB.y,vecA.z+10.5);
     a.normal(0,0,1);
     a.vertex(vecA.x+vecAB.x,vecA.y+vecAB.y,vecA.z+10.5);
     PVector tamp = new PVector(0,0,0);
     for (int p=1; p < coordinates.size()-1; p++) {         JSONArray point = coordinates.getJSONArray(p);
      
   Map3D.GeoPoint o = map.new GeoPoint(point.getDouble(0),point.getDouble(1));
   if(o.inside()){
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
   PVector in = new PVector(o2.x,o2.y,o2.z);
   tamp = in;
   PVector vIN = new PVector(in.y -vecAC.y,vecAC.x-in.x).normalize().mult(10/2.0f);
   a.normal(0,0,1);
   a.vertex(in.x-vIN.x,in.y-vIN.y,in.z+10.5);
   a.normal(0,0,1);
   a.vertex(in.x+vIN.x,in.y+vIN.y,in.z+10.5);
   }}
   if(opc.inside()){
   PVector vtamp = new PVector(tamp.y-vecC.y,vecC.x-tamp.x).normalize().mult(10/2.0f);
   a.normal(0,0,1);
   a.vertex(vecC.x+vtamp.x,vecC.y+vtamp.y,vecC.z+10.5);
   a.normal(0,0,1);
      a.vertex(vecC.x-vtamp.x,vecC.y-vtamp.y,vecC.z+10.5);}
 }break;}
   
   
   a.endShape();
   railways.addChild(a);
   }  
  

}//fermeture constructeur



void update(){
shape(railways);

}

void toggle(){
railways.setVisible(!this.railways.isVisible());
}


































}//fermeture calsse
