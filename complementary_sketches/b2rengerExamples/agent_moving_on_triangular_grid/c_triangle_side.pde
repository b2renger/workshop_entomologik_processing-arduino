class Triangle_side {
  float radius = 20;
  float x, y;
  float prevX, prevY;
  color col;
  float alph;


  Triangle_side(float x, float y, float radius) {
    this.x =x;
    this.y = y;
    this.radius=radius;
    this.col = col;
    this.alph = alph;

    x = width/2;
    y = height/2;

    prevX = x;
    prevY = y;
  }

  void run(float aH, float aS, float aB, float aA, float weight) {
    pushStyle();
    float angle = (TWO_PI / 6) * floor( random( 6 ));
    x += cos( angle ) * radius;
    y += sin( angle ) * radius;

    if ( x < 0 || x > width ) {
      x = prevX;
      y = prevY;
    }

    if ( y < 0 || y > height) {
      x = prevX;
      y = prevY;
    }

    noFill(); 
    stroke(aH, aS, aB, aA);
    strokeWeight( weight );
    line( x, y, prevX, prevY );

    strokeWeight(weight+2 );
    point( x, y );

    prevX = x;
    prevY = y;
    popStyle();
  }

  void setRadius(float newRadius) {
    radius = newRadius;
  }
}

