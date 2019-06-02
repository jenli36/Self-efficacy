import processing.serial.*;
import processing.sound.*;

Serial myPort;
String val;
ArrayList<Circle> circles = new ArrayList<Circle>();
SoundFile music;
PFont prompt;
PFont current;
int count = 0; // # of votes
boolean message;
boolean triggered;
int start1;
int start2;
final int DURATION = 3000;
final int WAITING = 2500;

void setup() {
  // screensize
  fullScreen();
  smooth();
  // portName that Arduino IDE is connecting to
 // String portName = Serial.list()[1];
  // sets up the serial
 // myPort = new Serial(this, portName, 9600);
  // sets up the fonts
  prompt = createFont("AvenirNext-Bold", 45);
  current = createFont("AvenirNext-Bold", 45);
  music = new SoundFile(this, "sound.mp3");
  music.amp(0.5); // the volumn  value is [0.0, 1.0] 
  message = false;
  triggered = false;
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
  // normal text to display
  if (triggered && millis() - start1 > WAITING) {
    message = true;
    start2 = millis();
    triggered = false;
  }
  if (!message) {
    text("I HAVE ONCE", 0, 10);
    text("DOUBTED", 0, 60);
    text("MY  EDUCATIONAL", 0, 150);
    text("SKILL  SET", 0, 230);
    // Displays the current number of people who said yes
    textFont(current, 40);
    text(count + " PEOPLE AGREED", 0, 320);
  } else {
    text("TALK TO", 0, 10);
    text("OUR TEAM MEMBERS", 0, 60);
    text("TO LEARN MORE →", 0, 150);
    if (millis() - start2 > DURATION) {
      message = false;
    }
  }    
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
  if (circles.size() > 35) {
    for (int i = 0; i < 15; i++) {
      circles.remove(0);
    }
  }
}

void mousePressed(){
    music.play();
    Circle c = new Circle();
    circles.add(c);
    count++;
    start1 = millis();
    triggered = true;
}

void keyPressed() {
  if (keyCode == UP) {
    circles.clear();
    count = 0;
  }
}

void serialEvent(Serial myPort) {
   if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    if (val != null) {
      music.play();
      Circle c = new Circle();
      circles.add(c);
      count++;
      start1 = millis();
      triggered = true;
    }
  }
}
