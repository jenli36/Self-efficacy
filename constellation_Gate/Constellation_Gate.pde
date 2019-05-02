import processing.sound.*;

ArrayList<Circle> circles = new ArrayList<Circle>();
SoundFile file;
Circle c;
PFont prompt;
PFont current;
int count = 0; // # of votes

//void settings() {
  
  //size(displayWidth, displayHeight);
  
//}

void setup() {
  fullScreen();
  prompt = createFont("AvenirNext-Bold", 45);
  current = createFont("AvenirNext-Bold", 45);
  file = new SoundFile(this, "sound.mp3");
  file.amp(0.7); // the volumn  value is [0.0, 1.0]
}

void draw() {
  // set the color of the background
  background(0);
  noCursor();
  // Displays the prompt
  textFont(prompt, 40);
  fill(255); // the color of the prompt
  textAlign(CENTER);
  // Setting for Gates
  text("HAVE  YOU  EVER", 820, 460);
  text("DOUBTED", 820, 525);
  text("YOUR  EDUCATIONAL", 820, 610);
  text("SKILL  SET?", 820, 690);
  // Displays the current number of people who said yes
  textFont(current, 40);
  text(count + " PEOPLE SAID YES", 820, 780);

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
  // Clear the entire thing once the connection exceeds 10
  if (circles.size() > 40) {
    for (int i = 0; i < 20; i++) {
      circles.remove(0);
    }
  }
}

 
void keyPressed(){
  if (keyCode == LEFT) {
    c = new Circle("Allen");
    circles.add(c);
    file.play();
    count++;
  } else if (keyCode == RIGHT) {
    c = new Circle("Gates");
    circles.add(c);
    file.play();
    count++;
  } else {
    circles.clear();
    count = 0;
  }
}
 
