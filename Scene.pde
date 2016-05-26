//Class that defines a scene
public class Scene {
 Color bgColor;
 float fov;
 ArrayList<Light> lights;
 ArrayList<Shape> shapes;
 
 public Scene() {
   bgColor = new Color();
   fov = 0;
   lights = new ArrayList<Light>();
   shapes = new ArrayList<Shape>();
 }
}