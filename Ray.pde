//Class that defines a ray
public class Ray {
  PVector origin, direction;
  
  public Ray(PVector o, PVector d) {
    origin = o;
    direction = d;
  }
  
  public PVector getOrigin() {
    return origin;
  }
  
  public PVector getDirect() {
    return direction;
  }
}