int cols, rows;
int scl = 20;
int w = 1600;
int h = 900;
Star[] stars = new Star[1200];
float speed;

float flying = 0;

float ry;

PShape spaceShip;
PShape sun;
PImage suntex;

float[][] terrain;

void setup() {
  size(800, 800, P3D);
  cols = w / scl;
  rows = h /scl;
  terrain = new float [cols][rows];
  spaceShip = loadShape("Grunt2.obj");
  sun = createShape(SPHERE, 50);

  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
    suntex = loadImage("sunTexture.jpg");
  }
}

void draw() {



  flying -= 0.09;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }


  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2+100);
  rotateX(PI/3);
  translate(-w/2, -h/2); 
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {

      //the z values are the only ones changing
      vertex( x*scl, y*scl, terrain[x][y]);
      vertex( x*scl, (y+1)*scl, terrain[x][y+1]);

      //rect(x*scl,y*scl,scl,scl);
    }
    endShape();
  }

  speed = map(mouseX, 0, width, 0.5, 10);

  translate(width/2 +30, height/30);

  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  pushMatrix();
  translate(width/2 +100 , height/2 -5 , width/2 );
  rotateX(PI);
  rotateZ(ry);
  rotateY(ry);
  sun.setTexture(suntex); 
  shape(sun);

  popMatrix();

  translate(width/2 -200 , height/2  , width/2 );
  rotateX(ry);
  scale (20);
  shape(spaceShip);
  ry += 0.015;
}