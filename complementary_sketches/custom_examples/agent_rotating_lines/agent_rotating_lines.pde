/*
this is not my own creation, but I created the class though
*/
// taken from this source
// http://www.openprocessing.org/sketch/14195
Rotating_Lines rt1, rt2, rt3, rt4; 

void setup() {
  size(1300, 600);
  background(0);
  smooth(8);
  noFill();
  colorMode(HSB, 255); // set hue saturation  & brightness
  strokeWeight(.2);

  rt1 = new Rotating_Lines(width/5*sqrt(255), width/2, height/2);
  rt2 = new Rotating_Lines(width/5*sqrt(25), width/2, height/2);
  rt3 = new Rotating_Lines(width/5*sqrt(255), width/2, height/2);
  rt4 = new Rotating_Lines(width/5*sqrt(255), width/2, height/2);
}

void draw() {
  //fill(0,5);
  //rect(0,0,width,height);
  //background(0);

  rt1.run();
  rt2.run();
  rt3.run();
  rt4.run();
}



