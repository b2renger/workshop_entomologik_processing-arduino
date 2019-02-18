
import processing.serial.*;
Serial myPort;  

int photor =0;
int pir = 0;

int pphotor =0;
int ppir =0;

void setup() {
  size(800, 500);


  // initialisation de la communication via usb depuis arduino
  // ATTENTION à bien utiliser le port adapté
  printArray(Serial.list());
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

  //stocker police dispo
  //String[] fontList = PFont.list();
  //afficher liste de polices
  //println(fontList);
}

void draw() {    
  background(0);
  fill(255);

  ellipse(width*0.5, height*0.5, photor, photor);
}  

void serialEvent (Serial myPort) {
  try {
    while (myPort.available() > 0) {
      String inBuffer = myPort.readStringUntil('\n');
      if (inBuffer != null) {
        if (inBuffer.substring(0, 1).equals("{")) {
          JSONObject json = parseJSONObject(inBuffer);
          if (json == null) {
            //println("JSONObject could not be parsed");
          } else {
            pphotor = photor;
            ppir = pir;
            photor    = json.getInt("photor");
            pir    = json.getInt("pir");

            JSONArray js  = loadJSONArray("data.json");
            // println(js.size());

            JSONObject njs = new JSONObject();
            njs.setString("timestamp", year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second());
            njs.setInt("luminosity", photor);
            njs.setInt("presence", pir);
            //println(njs);
            js.append(njs);
            //  println(js.size());
            saveJSONArray(js, "data/data.json");
          }
        } else {
        }
      }
    }
  } 
  catch (Exception e) {
  }
}
