float anchorX, anchorY;
float distance, orientation; 
float diam; 
float noiseF; 

void setup() {
  size(800, 600);
  background(100);

  diam = random(20,50);
  anchorX = width/2;
  anchorY = height/2;

  distance = 0;
  orientation = random(TWO_PI);

  noiseF = 5;

}

void draw() {

  diam -= 0.1;
  distance += 1; 
  orientation += map(noise(noiseF,10,20),0,1,-0.015,0.015);
  noiseF += 0.005;

  float  xpos = anchorX + distance * cos(orientation);
  float ypos = anchorY + distance * sin(orientation);

  ellipse(xpos,ypos,diam,diam);

 
  if(diam<0.1){
    noiseF = random(-1000,1000);
    diam = random(20,50);
    distance = 0;
    orientation = random(TWO_PI);
  }

}

void mousePressed(){
  anchorX = mouseX;
  anchorY = mouseY;
  diam = random(20,50);
}


