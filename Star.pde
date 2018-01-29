
class Star {
  
  float x, y;
  float z;

  //store previouse z to connect lines when speed inc
  float pz;

  Star() {
   
    x = random(-width/2, width/2);
   
    y = random(-height/2, height/50);
    
    z = random(width/2);
   
    pz = z;
  }

  void update() {
   
    z = z - speed;

    if (z < 1) {
      z = width/2;
      x = random(-width/2, width/10);
      y = random(-height/2, height/50);
      pz = z;
    }
  }

  void show() {
    
    color(1.0f,1.0f,1.0f);
    fill(random(0,250),random(0,250),random(0,250));
    noStroke();
  

    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);;
    

    // star size increases when it gets closer
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);

    // previous z pos responsible for line drawing for speed effect
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);
    pz = z;

    stroke(255);
    line(px, py, sx, sy);

  }
}