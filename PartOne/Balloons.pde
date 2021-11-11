/*
Encompasses: Displaying Balloons, Waves & Sending Balloons, Balloon Reaching End of Path, Health Bar
 */
 
class Balloon {
  float distanceTravelled = 0;
  int delay = 0;
  int speed = 0;
  color balloonColor = #f3cd64;
  Balloon(int dt, int dl, int sp, color bc) {
    distanceTravelled = dt;
    delay = dl;
    speed = sp;
    balloonColor = bc;
  }
  Balloon(int dt, int dl, int sp) {
    distanceTravelled = dt;
    delay = dl;
    speed = sp;
  }
  public void updatePositions() {
    // Only when balloonProps[1] is 0 (the delay) will the balloons start moving.
    if (delay == 0) {
      final int RADIUS = 25; //Radius of the balloon

      PVector position = getLocation(distanceTravelled);
      distanceTravelled += speed; //Increases the balloon's total steps by the speed

      //Drawing of ballon
      ellipseMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(balloonColor);
      ellipse(position.x, position.y, RADIUS, RADIUS);
    } else {
      delay--;
    }
  }
  boolean atEndOfPath() {
    float totalPathLength = 0;
    for (int i = 0; i < points.size() - 1; i++) {
      PVector currentPoint = points.get(i);
      PVector nextPoint = points.get(i + 1);
      float distance = dist(currentPoint.x, currentPoint.y, nextPoint.x, nextPoint.y);
      totalPathLength += distance;
    }
    if (distanceTravelled >= totalPathLength) return true; // This means the total distance travelled is enough to reach the end
    return false;
  }
}
ArrayList<Balloon> balloons = new ArrayList<Balloon>();
final int distanceTravelled = 0, delay = 1, speed = 2;

void createFirstWave() {
  //{Number of "steps" taken, frames of delay before first step, speed}
  balloons.add(new Balloon(0, 100, 3));
  balloons.add(new Balloon(0, 130, 3));
  balloons.add(new Balloon(0, 160, 2));
  balloons.add(new Balloon(0, 220, 4));
  balloons.add(new Balloon(0, 340, 2));
  balloons.add(new Balloon(0, 370, 2));
  balloons.add(new Balloon(0, 400, 5));
  balloons.add(new Balloon(0, 430, 5));
  balloons.add(new Balloon(0, 490, 3));
  balloons.add(new Balloon(0, 520, 1));
  balloons.add(new Balloon(0, 550, 3));
}

void drawBalloons() {
  for (int i = 0; i < balloons.size(); i++) {
    balloons.get(i).updatePositions();

    if (balloons.get(i).atEndOfPath()) {
      balloons.remove(i); // Removing the balloon from the list
      health--; // Lost a life.
      i--; // Must decrease this counter variable, since the "next" balloon would be skipped
      // When you remove a balloon from the list, all the indexes of the balloons "higher-up" in the list will decrement by 1
    }
  }
}

// ------- HP SYSTEM --------
/*
  Heath-related variables:
 int health: The player's total health.
 This number decreases if balloons pass the end of the path (offscreen), currentely 11 since there are 11 balloons.
 PImage heart: the heart icon to display with the healthbar.
 */
int health = 11;  //variable to track user's health
PImage heart;

void loadHeartIcon() {
  heart = loadImage("heart.png");
}
//method to draw a healthbar at the bottom right of the screen
void drawHealthBar() {
  //draw healthbar outline
  stroke(0, 0, 0);
  strokeWeight(0);
  fill(#830000);
  rect(721, 455, 132, 20);

  //draw healthbar
  noStroke();
  rectMode(CORNER);
  fill(#FF3131);
  rect(655, 445.5, health*12, 20); //the healthbar that changes based on hp
  rectMode(CENTER);
  noFill();

  //write text
  stroke(0, 0, 0);
  textSize(14);
  fill(255, 255, 255);
  text("Health:   "+health, 670, 462);

  //put the heart.png image on screen
  imageMode(CENTER);
  image(heart, 650, 456);
  noFill();
}
