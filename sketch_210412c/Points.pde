class Points{
public class Couples{
double x;
double y;
double z;

Couples(double abs, double ord,double z){
x= abs;
y = ord;
}//fin sous constr
}//fin sous classe
Couples[] tabP;
int c;
Points(String fileName){
  
  
  File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 
int c = 1;
 for(int f=0; f<features.size();f++){
 c++;
 
 
 
 
 }//fin for
 this.c = c-1;
  tabP= new Couples[c];
  getPoints(fileName);
  this.convertPoint();
 
  
}//fin Constructeur
void getPoints(String fileName){


File ressource = dataFile(fileName);
if (!ressource.exists() || ressource.isDirectory()) { 
  println("ERROR: GeoJSON file " + fileName + " not found.");
 return; } 
 JSONObject geojson = loadJSONObject(fileName);
 if (!geojson.hasKey("type")) {   println("WARNING: Invalid GeoJSON file.");   return; }
 else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) {   println("WARNING: GeoJSON file doesn't contain features collection.");   return;}
 JSONArray features =  geojson.getJSONArray("features"); 
 if (features == null) {   println("WARNING: GeoJSON file doesn't contain any feature.");   return; } 
   int compteur = 0;
 for(int f=0; f<features.size();f++){
   JSONObject feature = features.getJSONObject(f); 
   
   
   
   
   if (!feature.hasKey("geometry"))
   break;
   JSONObject geometry = feature.getJSONObject("geometry"); 
     switch (geometry.getString("type", "undefined")) { 
   
   case "Point":
   JSONArray coordinates = geometry.getJSONArray("coordinates");

         
   JSONArray point= coordinates;
 Couples cop= new Couples(point.getDouble(0),point.getDouble(1),0);
 this.tabP[compteur] = cop;
 compteur++;
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 }//fermeture switch
     




 }//fermeture for feature



}//fermeture get

void convertPoint(){
  
  
for(int k =0; k<this.c-1;k++){

  Map3D.GeoPoint o = map.new GeoPoint(  this.tabP[k].x,  this.tabP[k].y);
   
   Map3D.MapPoint mp = map.new MapPoint(o);
   Map3D.ObjectPoint o2 = map.new ObjectPoint(mp);
 tabP[k].x = o2.x;
 tabP[k].y = o2.y;
 tabP[k].z =o2.z;}
 
}


}//fermeture classe
