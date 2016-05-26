//Abstract class that defines all shapes
public abstract class Shape {
  Surface mySurface;
  abstract Hit intersect(Ray ray);
}