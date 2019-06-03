import processing.serial.*;
import processing.sound.*;

// random message to pick from
String[] messages = {"THANK YOU FOR SHARING ^_^", "YOUR STEP HAS AN IMPACT ^_^", 
"YOU ARE NOT ALONE,", " PEOPLE RESONATE WITH YOU"};
int index;  // random index of the messages

Serial myPort;  // arduino serial port
String val;  // value received from arduino

// current list of dots added
ArrayList<Circle> circles = new ArrayList<Circle>();
SoundFile music;  // the triggered sound file
PFont prompt; // Displayed text
int count = 0; // current number of votes by people
// whether to display the message
boolean message;
// detects if the sensor is triggered
boolean triggered; 
// whether people can interact with the sensor
boolean disable;
int start1;
int start2;
final int DURATION = 2500;
final int WAITING = 1000;

void setup() {
  fullScreen();
  smooth();
  // portName that Arduino IDE is connecting to
  String portName = Serial.list()[1];
  // sets up the serial
  myPort = new Serial(this, portName, 9600);
  // sets up the fonts
  prompt = createFont("AvenirNext-Bold", 40);
  music = new SoundFile(this, "sound.mp3");
  music.amp(0.5); // the volumn  value is [0.0, 1.0] 
  message = false;
  triggered = false;
  disable = false;
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
  textFont(prompt,40);
  // normal text to display
  if (triggered && millis() - start1 > WAITING) {
    message = true;
    start2 = millis();
    triggered = false;
  }
  if (!message) {
    text("I HAVE ONCE", 0, 0);
    text("DOUBTED", 0, 70);
    text("MY  EDUCATIONAL", 0, 150);
    text("SKILL  SET", 0, 230);
    // Displays the current number of people who said yes
    text(count + " PEOPLE AGREED TODAY", 0, 320);
  } else {
    if (index == 3) {
      text((count - 1) + messages[index], 0, 0);
    } else {
      text(messages[index], 0, 0);
    }
    text("TALK TO", 0, 70);
    text("OUR TEAM MEMBERS", 0, 150);
    text("TO LEARN MORE →", 0, 230);
    disable = true;
    if (millis() - start2 > DURATION) {
      message = false;
      disable = false;
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
  if (!disable) {
    music.play();
    Circle c = new Circle();
    circles.add(c);
    count++;
    start1 = millis();
    triggered = true;
    // generates a random index
    if (count == 1) {
      index = int(random(0,3));
    } else {
      index = int(random(0,4));
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    circles.clear();
    count = 0;
  }
}

void serialEvent(Serial myPort) {
   if (myPort.available() > 0 && !disable) {
    val = myPort.readStringUntil('\n');
    if (val != null) {
      music.play();
      Circle c = new Circle();
      circles.add(c);
      count++;
      start1 = millis();
      triggered = true;
      // generates a random index
      if (count == 1) {
        index = int(random(0,3));
      } else {
        index = int(random(0,4));
      }
    }
  }
}
