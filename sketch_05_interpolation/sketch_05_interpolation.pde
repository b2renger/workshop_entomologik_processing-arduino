
float xpos;
float ypos;

float xtarget;
float ytarget;

float sensitivity = 0.05;

void setup(){
  
  size(800, 600);
  
  xpos = width/2;
  ypos = height/2;
  
  xtarget = width/2;
  ytarget = height/2;
  
  background(0);
}


void draw(){
  background(0);
  
  if (mousePressed == true){
    xtarget = mouseX;
    ytarget = mouseY;
  }
  
  xpos = xpos + (xtarget-xpos)*sensitivity;
  ypos = ypos + (ytarget-ypos)*sensitivity;
  
  ellipse(xpos,ypos,50,50);
  
}
