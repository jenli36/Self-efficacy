 //int[] locationList = {};

public class Circle{
  PVector location,velocity,acceleration;
  float G,mass,size;
  String building;
  
  Circle(String building){
    this.building = building;
    if (building.equals("Gates")) { // prints to the right half
      location = new PVector(int(random(width / 2, width - 100)), int(random(200, height)));    
    } else {
      location = new PVector(int(random(100, width / 2)), int(random(200, height)));
    }
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    G = 0.6;
    mass = 2;
    size = 70;
  }

  void applyForce(PVector force){
    force.div(mass);
    acceleration.add(force);
  }

  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display(){
    noStroke();
    // makes the dot shrink to 8
    if (size > 10) {
      size--;
      noStroke();
    }
    fill(255);
    ellipse(location.x, location.y, size, size);
  }
  
  void link(Circle c){
    // stroke (rgb, alpha). alpha-> float: opacity of the stroke
    stroke(255, 75);
    strokeWeight(1.5);
    PVector dist = PVector.sub(c.location,location);
    // the magnitude of distance is less than 200, draw a line b/w the two
    if (dist.mag() > 250 && dist.mag() < 350) {
      line(location.x, location.y, c.location.x, c.location.y);
    }
  }
  
  // DO NOT CHANGE
  PVector attract(Circle c){
    PVector force = PVector.sub(location, c.location);
    float distance = force.mag();
    distance = constrain(distance, 20, 25);
    force.normalize();
    float strength = (G * mass * c.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  // DO NOT CHANGE
  // Once the circle hit the edges of the screen, change the direction
  void checkEdges(){
    if (location.x < size / 2) {
      location.x = size / 2;
      velocity.x *= -1;
    } else if (location.x > width - size / 2){
      location.x = width - size/2;
      velocity.x *= -1;
    }
    if (location.y < size / 2) {
      location.y = size / 2;
      velocity.y *= -1;
    } else if (location.y > height - size / 2){
      location.y = height - size / 2;
      velocity.y *= -1;
    }
  }
}
