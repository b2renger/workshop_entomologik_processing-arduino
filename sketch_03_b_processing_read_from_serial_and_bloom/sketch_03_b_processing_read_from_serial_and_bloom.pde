import processing.serial.*;
Serial myPort;

float centerSize = 50;
int valueFromArduino = 0;

void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

  // Serial init
  printArray(Serial.list()); // print the list of devices connected via usb
  String portName = Serial.list()[3]; // my arduino card is the third one on the list, check yours !
  myPort = new Serial(this, portName, 9600); // open up the communication
  myPort.bufferUntil('\n'); // mandatory for now
}

void draw() {
  background(0);

  pushMatrix();
  pushStyle();
  translate(width*0.5, height*0.5);

  centerSize = map(valueFromArduino, 0, 1023, 0, 150);
  
  for (int i = 0; i < 15; i++) {
    fill(25, 100, 100, 50);
    stroke (25, 100, 100, 50);
    strokeWeight(1);

    float x = cos(i*(TWO_PI )/15)*centerSize;
    float y = sin(i*(TWO_PI)/15)*centerSize;
    float rad = 75;
    ellipse(x, y, rad, rad);
  }

  for (int i = 0; i < 10; i++) {
    fill(45, 100, 100, 50);
    stroke (45, 100, 100, 50);
    strokeWeight(1);

    float x = cos(i*(TWO_PI)/10)*centerSize/2;
    float y = sin(i*(TWO_PI)/10)*centerSize/2;
    float rad = 100;
    ellipse(x, y, rad, rad);
  }

  fill(0, 100, 100, 100);
  stroke (0, 100, 100, 100);
  strokeWeight(1);
  ellipse(0, 0, centerSize, centerSize);

  popStyle();
  popMatrix();
}

void serialEvent (Serial myPort) {
  try { // we try to do something but do not worry if it doesn't work !
    while (myPort.available() > 0) {
      String inBuffer = myPort.readStringUntil('\n'); // read the data received
      if (inBuffer != null) { // if it's not empty
        if (inBuffer.substring(0, 1).equals("{")) { // and if it looks like json
          JSONObject json = parseJSONObject(inBuffer); // we try to read it as json 

          // Now you need to understand !!
          if (json == null) { // if it's no json we just don't do anything
          } else { //if it is json we get the data

            valueFromArduino    = json.getInt("valeur1");
          }
        }
        // we just need to close every curly bracket we opened ^^
      } else {
      }
    }
  }
  catch (Exception e) {
  }
} 
