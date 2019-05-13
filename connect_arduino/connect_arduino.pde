import processing.serial.*;
import processing.sound.*;

Serial myPort;
String val;
ArrayList<Circle> circles = new ArrayList<Circle>();
SoundFile music;
PFont prompt;
PFont current;
int count = 0; // # of votes
boolean read;
int time;

void setup() {
  // screensize
  fullScreen();
  // portName that Arduino IDE is connecting to
  String portName = Serial.list()[3];
  // sets up the serial
  myPort = new Serial(this, portName, 9600);
  // sets up the fonts
  prompt = createFont("AvenirNext-Bold", 45);
  current = createFont("AvenirNext-Bold", 45);
  music = new SoundFile(this, "sound.mp3");
  music.amp(0.7); // the volumn  value is [0.0, 1.0] 
  read = true;
  time = millis();
}

void draw() {
  background(0);  // set the color of the background
  noCursor();  // does not show cursor
  fill(255); // the color of the prompt
  float x = width / 2;
  float y = 460;
  textAlign(CENTER, BOTTOM);
  pushMatrix();
  translate(x,y);
  textFont(prompt, 40);
  // Setting for Gates
  text("HAVE  YOU  EVER", 0, 0);
  text("DOUBTED", 0, 65);
  text("YOUR  EDUCATIONAL", 0, 150);
  text("SKILL  SET?", 0, 230);
  // Displays the current number of people who said yes
  textFont(current, 40);
  text(count + " PEOPLE SAID YES", 0, 320);
  popMatrix();
 
  
  // DO NOT CHANGE
  for (int i = 0; i < circles.size(); i++) {
    for (int j = 0; j < circles.size(); j++) {
      if (i != j) {
        PVector f = circles.get(j).attract(circles.get(i));
        circles.get(i).applyForce(f);
        circles.get(i).link(circles.get(j));
      }
    }
    circles.get(i).update();
    circles.get(i).display();
    circles.get(i).checkEdges();
  }
  // Clear the entire thing once the connection exceeds 40
  if (circles.size() > 40) {
    for (int i = 0; i < 20; i++) {
      circles.remove(0);
    }
  }
}

void serialEvent(Serial myPort) {
   if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    if (val != null) {
  //    read = false; 
  //    time = millis();
      music.play();
      Circle c = new Circle("Allen");
      circles.add(c);
      count++;
    }

  }
  //if (time + 3000 > millis()) {
  //  read = true;
  //}
}
