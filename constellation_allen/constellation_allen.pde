import processing.sound.*;

ArrayList<Circle> circles = new ArrayList<Circle>();
SoundFile file;
PFont prompt;
PFont current;
int count = 0; // # of votes


void setup() {
  fullScreen();
  prompt = createFont("AvenirNext-Bold", 45);
  current = createFont("AvenirNext-Bold", 45);
  file = new SoundFile(this, "sound.mp3");
  file.amp(0.7); // the volumn  value is [0.0, 1.0]
}

void draw() {
  // set the color of the background
  background(0); // black background
  //background(255); // white background
  noCursor();
  // Displays the prompt
  textFont(prompt, 30);
 // fill(0); // black text
  fill(255); // white text
  // setting for the Allen
  textAlign(CENTER,BOTTOM);

  pushMatrix();
  float x = 740;
  float y = 260;
  translate(x,y);
  //rotate(HALF_PI);
  text("HAVE  YOU  EVER", 0, 18);
  text("DOUBTED", 0, 145);
  text("YOUR  EDUCATIONAL", 0, 270);
  text("SKILL  SET?", 0, 395);
  // Displays the current number of people who said yes
  textFont(current, 30);
 // popMatrix();
  //pushMatrix();
  //float x1 = 850;
  //float y1 = 460;
  //translate(x1, y1);
  //rotate(-85);
  text(count + " PEOPLE SAID YES", 0, 515);
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
  // Clear the entire thing once the connection exceeds 10
  if (circles.size() > 40) {
    for (int i = 0; i < 20; i++) {
      circles.remove(0);
    }
  }
}

 
void keyPressed(){
  if (keyCode == LEFT) {
    noLoop();
  } else if (keyCode == RIGHT) {
    noLoop();
  } else {
    circles.clear();
    count = 0;
  }
}
 
void keyReleased() {
  if (keyCode == LEFT) {
    loop();
    Circle c = new Circle("Allen");
    circles.add(c);
//    file.play();
    count++;
  } else if (keyCode == RIGHT) {
    loop();
    Circle c = new Circle("Gates");
    circles.add(c);
 //   file.play();
    count++;
  } else {
    circles.clear();
    count = 0;
  }
}
