//Class that defines a sphere
public class Sphere extends Shape {
  float r;
  PVector center;
  
  public Sphere(float r, float x, float y, float z, Surface m) {
    this.r = r;
    center = new PVector(x,y,z);
    mySurface = m;
  }
  
  public Hit intersect(Ray ray) {
    PVector origin = ray.getOrigin();
    PVector direction = ray.getDirect();
    
    PVector newOrigin = PVector.sub(ray.getOrigin(), center);
    float a = ray.direction.dot(ray.direction);
    float b = 2*(newOrigin.dot(ray.direction));
    float c = newOrigin.dot(newOrigin)-sq(r);
    
    float disc = sq(b)-(4*a*c);
    if(disc<0) { return null; }
    
    float t;
    float negT = ((-1*b)-sqrt(disc))/(2*a);
    float posT = ((-1*b)+sqrt(disc))/(2*a);
    if(negT<posT && negT>0) {
      t = negT;
    } else if(posT>0) {
      t = posT;
    } else { return null; }
    
    PVector P = new PVector(origin.x + (t*direction.x),
                            origin.y + (t*direction.y),
                            origin.z + (t*direction.z));
    PVector sNormal = PVector.sub(P,center);
    sNormal.normalize();
    
    Hit hit = new Hit(P, sNormal);
    return hit;
  }
}