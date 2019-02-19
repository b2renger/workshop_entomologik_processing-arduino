In this repo we will work with [processing](https://processing.org/) and [arduino](https://www.arduino.cc/). Both environment have made it possible over the years for designers and artists to produce [rich interactive experiences and artworks](https://processing.org/exhibition/) both in the field of multimedia programming (processing) and electronics (arduino).

# Arduino

Your main ressource about arduino will be located [here](https://github.com/b2renger/Introduction_arduino#contenu), it's in french, but having the code and the schematics of the circuits should be enough for most usages. This introduction covers some sensors and actuators but far from everything that is possible to do with arduino. One interesting part for us will be the part explaining communication between processing and arduino via **Serial** (Universal Serial Bus i.e. USB). Right at the end, three examples will explain to you [how to control the playback of video with a distance sensor](https://github.com/b2renger/Introduction_arduino#controler-le-playback-dune-vid%C3%A9o-avec-un-capteur-de-distance), [how to control an animation with a photoresistance](https://github.com/b2renger/Introduction_arduino#controler-une-animation-avec-une-photoresistance) and finally the other way around [how to send mouse coordinates to arduino to light up a RGB led strip](https://github.com/b2renger/Introduction_arduino#controler-des-leds-neopixels-avec-la-souris) - this one is a little bit harder. But we will get back to this later on.

First you should spend some time with arduino, discover the examples : build the circuit, upload the code and try to make things move / sense.

Next we will take a deeper look at processing.


# Processing - drawing a flower

*Processing seeks to ruin the careers of talented designers by tempting them away from their usual tools and into the world of programming and computation. Similarly, the project is designed to turn engineers and computer scientists to less gainful employment as artists and designers.*

Appart from this processing is an amazing middleware to make things communicate, sketch simple things through code etc.


## Getting started

This [first link](https://processing.org/tutorials/gettingstarted/) should get you started with processing. You'll get the basics of the interface a write your first sketch : an ellipse following the mouse !

This [second link](https://processing.org/tutorials/drawing/) will give you a little more insights about the coordinate system of processing and the difference kind of shapes you can draw.


## The flower project

So let's get started on our flower project ! In this project we will get used to the processing environment and draw some shapes. We will use the HSB color mode and polar coordinate system to draw some flowers, then we will see how to parametrize those and animate them using data coming from an arduino card.

### Our first flower

#### A simple circle

First we will need to draw the center : a simple circle will do.


```java
void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width*0.5, height*0.5);
             
  fill(0, 100, 100, 100);
  stroke (0, 100, 100, 100);
  strokeWeight(1);
  ellipse(0, 0, 100, 100);
  popMatrix();
}
```

The **setup()** function is run only once at the start of our program (when we click play) it is used to initialize things for our program. Here we :

- set the [**size**](https://processing.org/reference/size_.html) of our drawing window.

- set the [background](https://processing.org/reference/background_.html) to black.

- set the [colorMode](https://processing.org/reference/colorMode_.html) of our sketch to HSB (Hue Saturation Brightness). 
This will impact every call we make to [fill()](https://processing.org/reference/fill_.html) or [stroke()](https://processing.org/reference/stroke_.html) since the four paramater we will have to pass will be the  hue (between 0 and 360), saturation (between 0 = no saturation and 100 = full colors) and brightness (0 = black and 100 = full brightness), opacity will be an optional fourth paramater (between 0 = full transparent and 100 = opacity to the max.)

The **draw()** function will be called repeatidly once the program is running we will use it to draw and program interactivity with our drawings.

Again we set the background to black thus erasing previous things that were drawn.

Then we use [**pushMatrix()**](https://processing.org/reference/pushMatrix_.html) coupled with a [**popMatrix()](https://processing.org/reference/popMatrix_.html) - at the end of the draw function.

To understand a little further the way transformation of the space work in processing you can [check this example out](https://www.openprocessing.org/sketch/388513) :
In black is the original processing coordinate system. 
In red is the coordinate system after having called :
```java
translate(mouseX, mouseY);
```
In blue is the coordinate system after having called :
```
translate(mouseX, mouseY);
rotate(PI/5);
```

So we just use this in combination with
```
translate(width*0.5, height*0.5);
````
to place us at the center of our drawing window. 

After that we can prepare to start drawing by specifying the fill and stroke of our future drawing (remember you always need to choose your pen before you start drawing !). And finally comes our [ellipse()](https://processing.org/reference/ellipse_.html). We will draw it at (0,0) since we translated our coordonate system to the center of the window and its diameter will be 100 pixels.

#### A for() loop for the petals

Now we need to draw some petals : it will be a little more tricky as we will use a [for()](https://processing.org/reference/for.html) loop.

As you have read in the documentation a for loop is used to make iteration. For instance if you want to draw a 100 circles, you'll use a for loop executing some code a hundred times.

For instance :

```java
void setup(){
    size(800, 600);
    background(0);
    colorMode(HSB, 360, 100, 100, 100);
}

void draw(){
    background(0);
    
    for (int i = 0 ; i < 99 ; i++){
        stroke(random(360), 100, 100, 90);
        float radius = random(25, 100);
        ellipse(random(width), random(height), radius, radius );
    
    }
    noLoop();    
}
```

Now what we want to do here is to draw let's say 10 circles, which center will be placed on the edge of our previous circle.

We will use [polar coordinates](https://en.wikipedia.org/wiki/Polar_coordinate_system). It's just a fancy way of placing objects in space using a angle and a distance instead of using x and y coordinates.

It will be easier for us since what we want to do is actually place 10 circles on the edge of our center circle : then our distance will be always the same ie **100*0.5** the radius of our center circle. And we will want to use angles that varies from 0 to 2*PI at the step of **2*PI/10** as we want to achieve a full revolution and we want our circle to be even spaced.

Once we figured this out we just need to apply a formula to transform our polar coordinates into cartesian coordinates that we can draw with processing.

```
x = centerX + distance * cos(angle);
y = centerY + distance * sin(angle);
```

```java
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

 
  for (int i = 0; i < 10; i++) {
    fill(45, 100, 100, 50);
    stroke (45, 100, 100, 50);
    strokeWeight(1);
    // the formula is here : https://www.openprocessing.org/sketch/151087
    float x = 0 + cos(i*(TWO_PI)/10)*100/2;
    float y = 0 + sin(i*(TWO_PI)/10)*100/2;
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
```

Now you can probably draw a second corolla of petals again on the edge of the last corolla :

```java
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

```

Once it is done you will find yourself with a beautifull flower like this one :

![first flower](images/flower1.png)
    
You will find the code for this first sketch in the folder "sketch_01_first_flower".

    
### Let's use a variable to parametrize our flower and make it bloom !

To make our flower bloom we will need to create a **variable**. A variable is a space in our computer's memory where we store something alongside with a name (of your choosing) to enable easy access to this value either to read it or to modify it.

We can store many things in the memory defined by their type :
- **float** to store a decimal number
- **int** to store integers numbers.
- **String** to store some text
- **boolean** to store a 0 or 1 which is equivalent to *false* or *true*.

Here we will want to define a float that will be used to define the size of the center of our flower.

```java
float centerSize = 50;
```

One important notion is the **scope** of the variable. The scope is the chunck of code in which the variable exists : the scope of any variable is limited to the opening curly bracket **{** preceeding it and the closing curly bracket **}** following it. If you create a variable before the setup() it will be available all over the program. If you create in the setup it will only exist in the setup; if you create one in a if statement it will only exist in this precise if statement etc.

So we will want to create a global variable : available in our whole program ie before the setup.

Now we will use it ! This variable will impact the size of the ellipse we are drawing

```java
ellipse(0, 0, centerSize, centerSize);
```

But also how we calculate the positions of the petals of our corollas.

```java
for (int i = 0; i < 10; i++) {
    fill(45, 100, 100, 50);
    stroke (45, 100, 100, 50);
    strokeWeight(1);

    float x = cos(i*(TWO_PI)/10)*centerSize/2;
    float y = sin(i*(TWO_PI)/10)*centerSize/2;
    float rad = 100;
    ellipse(x, y, rad, rad);
}
```

Here is the full code with the centerSize variable used :

```java
float centerSize = 50;

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
```

Now to make this more interactive we will enable our user to change the centerSize variable with their mouse. For this we will need to [**map()**](https://processing.org/reference/map_.html) the position of our mouse to values that could be used as our centerSize variable.

```java
centerSize = map(mouseX, 0, width, 0, 150);
```
This line of code will be written in the draw() function as we want to calculate a new size for our center each time the user moves the mouse. If the mouse position is on the far left of the screen our centerSize variable will be 0, if it's on the far right centerSize will be 150 thus making the flower bloom when the user move the mouse from left to right.

You will find the code for this first sketch in the folder "sketch_02_blooming_flower".

Next step will be to make it bloom with some data coming from arduino !


## More ressources on Processing

- the official reference of the language : https://processing.org/reference/

- official tutorials : https://processing.org/tutorials/

- fun programming videos : https://funprogramming.org/


# Processing + arduino == fun !


    



# Digging a little deeper with Processing

## Genetic flower

### Genome

### Parent1 and Parent2 get a child

### Mutations

### A population of flowers

## Other bio inspired examples

- Examples from nature of code
- Examples from Genrative design (noise fields etc.)
- Custom examples