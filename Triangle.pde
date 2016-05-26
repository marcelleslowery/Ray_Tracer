//Class that defines a triangle
public class Triangle extends Shape {
  PVector P0, P1, P2;
  
  public Triangle(PVector P0, PVector P1, PVector P2, Surface m) {
    this.P0 = P0;
    this.P1 = P1;
    this.P2 = P2;
    mySurface = m;
  }
  
  public Hit intersect(Ray ray) {
    PVector origin = ray.getOrigin();
    PVector direction = ray.getDirect();
    
    PVector E1 = PVector.sub(P1, P0);
    PVector E2 = PVector.sub(P2, P1);
    PVector E3 = PVector.sub(P0, P2);
    PVector sNormal = new PVector();
    PVector.cross(E1, E2, sNormal);
    sNormal.normalize();
    
    float d = -(sNormal.dot(P0));
    float parallel = sNormal.dot(direction);
    if(parallel==0) { return null; }
    float t = -(sNormal.dot(origin) + d)/parallel;
    if(t<0) { return null; }
    
    PVector P = new PVector(origin.x + (t*direction.x),
                            origin.y + (t*direction.y),
                            origin.z + (t*direction.z));
    
    PVector pP0 = PVector.sub(P, P0);
    PVector pP1 = PVector.sub(P, P1); //points
    PVector pP2 = PVector.sub(P, P2);
    
    PVector t1 = new PVector();
    t1 = PVector.cross(E1, pP0, t1);
    PVector t2 = new PVector();
    t2 = PVector.cross(E2, pP1, t2);
    PVector t3 = new PVector();
    t3 = PVector.cross(E3, pP2, t3);
    
    float test1 = t1.dot(sNormal);
    float test2 = t2.dot(sNormal);
    float test3 = t3.dot(sNormal);
    
    if(test1<0 || test2<0 || test3<0) { return null; } //failed
    
    Hit hit = new Hit(P, sNormal);
    return hit;
  }
}