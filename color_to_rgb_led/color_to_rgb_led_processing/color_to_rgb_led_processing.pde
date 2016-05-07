import processing.serial.*;
Serial myPort;  
float pixel = 25;

color c=0;
int red=0, green=0, blue=0;

void setup() {
  String portName = "/dev/cu.usbmodem1421";
  myPort= new Serial(this, portName, 115200);

  size(640, 640);
  colorMode(HSB, pixel);
  noStroke();

  for (float i = 0; i <= pixel; i++) {
    fill(i, pixel, pixel); 
    rect((i/pixel)*width, height/3.0, width/pixel+1, height/3.0+1);
    for (float j = 0; j <= pixel; j++) {
      for (float k = 0; k <= pixel; k++) {
        fill(i, j, pixel); 
        rect((i/pixel)*width, (j/pixel/3.0)*height, width/pixel+1, height/pixel/3.0+1);
        fill(i, pixel, pixel-k); 
        rect(i*width/pixel, height*2.0/3.0 + k*height/pixel/3.0, width/pixel+1, height/pixel/3.0+1);
      }
    }
  }
}

void draw() {

  colorMode(HSB, pixel);

  if (mouseY<height/3.0) {
    c = color(mouseX*pixel/width, mouseY*(pixel*3.0)/height, pixel);
  } else if (mouseY>height/3.0 && mouseY<height*2.0/3.0) {
    c = color(mouseX*pixel/width, pixel, pixel);
  } else if (mouseY>height*2.0/3.0) {
    c = color(mouseX*pixel/width, pixel, pixel - (mouseY-height*2.0/3.0)*(pixel*3.0)/height);
  }
  red = int(red(c)/pixel *255.0);
  green = int(green(c)/pixel *255.0);
  blue = int(blue(c)/pixel *255.0);
  println(red, green, blue);
  colorMode(RGB, 255);
  fill(red, green, blue);
  strokeWeight(1);
  stroke(0);
  rect(0, 0, 100, 100);
}
void serialEvent(Serial myPort) { 
  int inByte = myPort.read(); 
  //println(inByte);
  byte out[] = new byte[3];
  out[0] = byte(red);
  out[1] = byte(green);
  out[2] = byte(blue);
  myPort.write(out);
} 

