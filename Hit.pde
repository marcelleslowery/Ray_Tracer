//Class that defines a ray-object intersection
public class Hit {
  PVector position, sNormal;
  Shape shape;
  
  public Hit(PVector p, PVector n) {
    position = p;
    sNormal = n;
  }
  
  public PVector getPosition() {
    return position;
  }
  
  public PVector getSNorm() {
    return sNormal;
  }
  
  public Shape getShape() {
    return shape;
  }
  
  public void setShape(Shape s) {
    shape = s;
  }
}