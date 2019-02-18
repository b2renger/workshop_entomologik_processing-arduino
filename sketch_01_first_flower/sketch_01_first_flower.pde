
void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(0);

  pushMatrix();
  pushStyle();
  translate(width*0.5, height*0.5);

  
  for (int i = 0; i < 15; i++) {
    fill(25, 100, 100, 50);
    stroke (25, 100, 100, 50);
    strokeWeight(1);

    float x = cos(i*(TWO_PI )/15)*100;
    float y = sin(i*(TWO_PI)/15)*100;
    float rad = 75;
    ellipse(x, y, rad, rad);
  }
 
  for (int i = 0; i < 10; i++) {
    fill(45, 100, 100, 50);
    stroke (45, 100, 100, 50);
    strokeWeight(1);

    float x = cos(i*(TWO_PI)/10)*100/2;
    float y = sin(i*(TWO_PI)/10)*100/2;
    float rad = 100;
    ellipse(x, y, rad, rad);
  }
 
  fill(0, 100, 100, 100);
  stroke (0, 100, 100, 100);
  strokeWeight(1);
  ellipse(0, 0, 100, 100);

  popStyle();
  popMatrix();
}
