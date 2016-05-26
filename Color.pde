//Class that defines a color
public class Color {
  float r,g,b;
  
  public Color() {
    this.r = 0;
    this.g = 0;
    this.b = 0;
  }
  
  public Color(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public void multiply(Color n) {
    this.r *= n.r;
    this.g *= n.g;
    this.b *= n.b;
  }
}