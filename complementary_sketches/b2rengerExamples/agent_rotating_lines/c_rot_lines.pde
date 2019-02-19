class Rotating_Lines {

  int turn =0 ;
  float radius ;
  float cenX, cenY ;
  
  float noiseFx, noiseFy;

  Rotating_Lines(float radius, float cenX, float cenY) {
    this.radius = radius;
    this.cenX = cenX;
    this.cenY = cenY;
    
    noiseFx = random(500);
    noiseFy = random(500);
  }

  void run() {
    
    cenX += map(noise(noiseFx,20,50),0,1,-2,2);
    cenY += map(noise(noiseFy,85,5),0,1,-2,2);
    
    if (cenX > width) cenX = 0;
    else if (cenX <0) cenX = width;
    else if (cenY <0) cenY = height;
    else if (cenY >height) cenY = 0;
    
    for (int d = 0; d <= 180; d+=15) {
      float r = radians(d + turn);
      stroke(d/10+5, 0, 255, 10);    
      bezier(cenX, cenY,
        cenX + radius / 2 * cos(r), cenY + radius / 2 * sin(r),
        cenX + radius * cos(r + HALF_PI), cenY + radius * sin(r + HALF_PI), 
        cenX + radius * cos(r + PI), cenY + radius * sin(r + PI)
        );
    }
  turn++;
  noiseFx+=0.005;
  noiseFy+=0.005;
  }
}

