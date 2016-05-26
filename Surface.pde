//Classs that defines a surface
public class Surface {
  Color diffuse, ambient, specular, shapeColor;
  float P,K;
  
  public Surface(float Cdr, float Cdg, float Cdb, 
                 float Car, float Cag, float Cab, 
                 float Csr, float Csg, float Csb,
                 float P, float K) {
    diffuse = new Color(Cdr, Cdg, Cdb);
    ambient = new Color(Car, Cag, Cab);
    specular = new Color(Csr, Csg, Csb);
    this.P = P;
    this.K = K;
  }

  public Color shade(Hit hitPoint, ArrayList<Light> lights, Ray ray, float depth) {
    shapeColor = new Color();
    Color diffuseC = new Color();
    Color ambientC = new Color(this.ambient.r,
      this.ambient.g, this.ambient.b);
    Color specC = new Color(this.specular.r,
      this.specular.g, this.specular.b);
    
    for(Light l : lights) {
      Color lColor = l.getColor();
      
      PVector lPosition = l.getPosition();
      PVector Pos = hitPoint.getPosition();
      PVector N = hitPoint.getSNorm();
      PVector L = PVector.sub(lPosition,Pos);
      L.normalize();
      float L_N = max(0, L.dot(N));
      
      //specular stuff
      PVector E = PVector.sub(ray.origin, Pos);
      E.normalize();
      PVector H = PVector.add(L,E); //halfway vector
      H.normalize();
      float phong = max(0, pow(H.dot(N), this.P));
      
      diffuseC.r += (lColor.r*L_N)*visible(Pos, L, N);
      diffuseC.g += (lColor.g*L_N)*visible(Pos, L, N);
      diffuseC.b += (lColor.b*L_N)*visible(Pos, L, N);
      
      specC.r *= (lColor.r*phong)*visible(Pos, L, N);
      specC.g *= (lColor.g*phong)*visible(Pos, L, N);
      specC.b *= (lColor.b*phong)*visible(Pos, L, N);
    }
    
    diffuseC.multiply(this.diffuse);
    shapeColor.r += ambientC.r+(diffuseC.r+specC.r);
    shapeColor.g += ambientC.g+(diffuseC.g+specC.g);
    shapeColor.b += ambientC.b+(diffuseC.b+specC.b);
    
    return shapeColor;
  }
  
  public float visible(PVector Pos, PVector L, PVector N) {
    float e1 = .001*N.x;
    float e2 = .001*N.y;
    float e3 = .001*N.z;
    PVector nPos = Pos;
    nPos.add(e1,e2,e3);
    Ray shadowRay = new Ray(nPos, L);
    Hit hit = null;
    for(int i=0; i<scene.shapes.size(); i++) {
      Shape O = scene.shapes.get(i);
      hit = O.intersect(shadowRay);
      if(null!=hit) {
        return 0.0;
      }
    }
    return 1.0;
  }
}