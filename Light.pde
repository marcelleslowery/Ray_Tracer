//Class that defines a light source
public class Light {
  PVector position;
  Color lcolor;
  
  public Light(float x, float y, float z, float r, float g, float b) {
    position = new PVector(x,y,z);
    lcolor = new Color(r,g,b);
  }
  
  public PVector getPosition() {
    return position;
  }
  
  public Color getColor() {
    return lcolor;
  }
}