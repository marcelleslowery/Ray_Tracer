// Marcelles Lowery

String gCurrentFile = new String("i0.cli");
ArrayList<PVector> points;
Scene scene;
Surface surf;

void setup() {
  size(500, 500);  
  noStroke();
  colorMode(RGB, 1.0);
  background(0, 0, 0);
  interpreter();
}

void reset_scene() {
  //reset global scene variables
  scene = new Scene();
}

void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  gCurrentFile = new String("i1.cli"); interpreter(); break;
    case '2':  gCurrentFile = new String("i2.cli"); interpreter(); break;
    case '3':  gCurrentFile = new String("i3.cli"); interpreter(); break;
    case '4':  gCurrentFile = new String("i4.cli"); interpreter(); break;
    case '5':  gCurrentFile = new String("i5.cli"); interpreter(); break;
    case '6':  gCurrentFile = new String("i6.cli"); interpreter(); break;
    case '7':  gCurrentFile = new String("i7.cli"); interpreter(); break;
    case '8':  gCurrentFile = new String("i8.cli"); interpreter(); break;
    case '9':  gCurrentFile = new String("i9.cli"); interpreter(); break;
    case '0':  gCurrentFile = new String("i10.cli"); interpreter(); break;
  }
}

float get_float(String str) { return float(str); }

// this routine helps parse the text in a scene description file
void interpreter() {
  println("Parsing '" + gCurrentFile + "'");
  String str[] = loadStrings(gCurrentFile);
  if (str == null) println("Error! Failed to read the file.");
  for (int i=0; i<str.length; i++) {
    
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov")) {
      scene.fov =get_float(token[1]);
    }
    else if (token[0].equals("background")) {
      scene.bgColor.r =get_float(token[1]);
      scene.bgColor.g =get_float(token[2]);
      scene.bgColor.b =get_float(token[3]);
    }
    else if (token[0].equals("light")) {
      Light light = new Light(get_float(token[1]),
                              get_float(token[2]),
                              get_float(token[3]),
                              get_float(token[4]),
                              get_float(token[5]),
                              get_float(token[6]));
      scene.lights.add(light);
      
      //float x =get_float(token[1]);
      //float y =get_float(token[2]);
      //float z =get_float(token[3]);
      //float r =get_float(token[4]);
      //float g =get_float(token[5]);
      //float b =get_float(token[6]);
    }
    else if (token[0].equals("surface")) {
      surf = new Surface(get_float(token[1]),
                                 get_float(token[2]),
                                 get_float(token[3]),
                                 get_float(token[4]),
                                 get_float(token[5]),
                                 get_float(token[6]),
                                 get_float(token[7]),
                                 get_float(token[8]),
                                 get_float(token[9]),
                                 get_float(token[10]),
                                 get_float(token[11]));
       
      //float Cdr =get_float(token[1]);
      //float Cdg =get_float(token[2]);
      //float Cdb =get_float(token[3]);
      //float Car =get_float(token[4]);
      //float Cag =get_float(token[5]);
      //float Cab =get_float(token[6]);
      //float Csr =get_float(token[7]);
      //float Csg =get_float(token[8]);
      //float Csb =get_float(token[9]);
      //float P =get_float(token[10]);
      //float K =get_float(token[11]);
    }    
    else if (token[0].equals("sphere")) {
      Sphere s = new Sphere(get_float(token[1]),
                            get_float(token[2]),
                            get_float(token[3]),
                            get_float(token[4]),
                            surf);
      scene.shapes.add(s);
      
      //float r =get_float(token[1]);
      //float x =get_float(token[2]);
      //float y =get_float(token[3]);
      //float z =get_float(token[4]);
    }
    else if (token[0].equals("begin")) {
      points = new ArrayList<PVector>();
    }
    else if (token[0].equals("vertex")) {
      points.add(new PVector(get_float(token[1]),
                             get_float(token[2]),
                             get_float(token[3])));
      //float x =get_float(token[1]);
      //float y =get_float(token[2]);
      //float z =get_float(token[3]);
    }
    else if (token[0].equals("end")) {
      Triangle t = new Triangle(points.get(2), //works when put in backwards
                                points.get(1),
                                points.get(0),
                                surf);
      scene.shapes.add(t);
    }
    else if (token[0].equals("rect")) {   // this command demonstrates how the parser works
      float x =get_float(token[1]);       // and is not really part of the ray tracer
      float y =get_float(token[2]);
      float w =get_float(token[3]);
      float h =get_float(token[4]);
      fill (255, 255, 255);  // make the fill color white
      rect (x, y, w, h);     // draw a rectangle on the screne
    }
    else if (token[0].equals("write")) {
      draw_scene();   // this is where you actually perform the ray tracing
      println("Saving image to '" + token[1]+"'");
      save(token[1]); // this saves your ray traced scene to a PNG file
    }
  }
}

// This is where you should put your code for creating
// eye rays and tracing them.
void draw_scene() {
  Hit hit = null;
  float k = tan(radians(scene.fov/2)); //dont forget bg colors
  for(int y = 0; y < height; y++) {
    float dy = -(y-(height/2))*((2*k)/height);
    for(int x = 0; x < width; x++) {
      fill(scene.bgColor.r,scene.bgColor.g,scene.bgColor.b);
      // create and cast an eye ray
      float dx = (x-(width/2))*((2*k)/width);
      PVector origin = new PVector(0,0,0);
      PVector direction = new PVector(dx,dy,-1);
      direction.normalize();
      Ray currRay = new Ray(origin, direction);
      
      for(int i=0; i<scene.shapes.size(); i++) {
        Shape O = scene.shapes.get(i);
        hit = O.intersect(currRay);
        if(hit!=null) {
          hit.setShape(O);
          Color shading = O.mySurface.shade(hit, scene.lights, currRay, 0);
          fill(shading.r,shading.g,shading.b);
        }
      }
      // make a tiny rectangle to fill the pixel
      rect(x,y,1,1);
    }
  }
}

void draw() {
  // nothing should be placed here for this project
}