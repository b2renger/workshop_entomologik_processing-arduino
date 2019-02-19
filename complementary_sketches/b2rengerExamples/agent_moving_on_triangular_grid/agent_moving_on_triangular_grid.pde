/* 
/*
This sketch is an agent moving on an triangular equilateral grid.
It would be nice to have a gui lib to act upon the drawing while it's running

You need to know 
- oop
- polar coordinates

this example will need sliders and gui elements to tweak things while running
*/

Triangle_side ts1,ts2;


void setup() {
  size( 1100, 700 );
  background( 0 );
  smooth();

  colorMode(HSB, 360, 100, 100, 255);

  ts1 = new Triangle_side(width/2, height/2, 25);
  ts2 = new Triangle_side(width/2, height/2, 15);

}

void draw() {

    ts1.run(50, 100, 100, 120, 1);
    ts1.setRadius(5);

    ts2.run(25, 100, 100, 120, 1);
    ts2.setRadius(5);

}


