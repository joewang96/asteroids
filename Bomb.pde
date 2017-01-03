class Bomb extends Projectile {
  
  /** 
  The main idea behind the bombs is that they would travel slower than the missiles,
  however when they collided with an asteroid they would create a 'blast radius' which
  would destroy other asteroids inside it. 
  
  Unforunatley, I did not have enough time to implement this aspect of my game.
  The game still meets the inheritance requirements, since I have the two different
  types of asteroids extending from the same abstract class. I decided to keep this
  class and comment out the sections that included the bombs and how they would work
  so I could show you what I was thinking (and so I could go back and add in these
  features later if I wish).
  **/
  
  // super constructor and defining speed for the missile
  public Bomb(int x, int y, float theta) {
    super(x, y, theta);
    this.setSpeed(3);
  }
  
  void display() {
    fill(255, 0, 0);
    noStroke();
    //stroke(255);
    ellipseMode(CENTER);
    pushMatrix();
    translate(width/2, height/2); 
    rotate(this.getTheta() - (PI/2)); // rotate the canvas
    ellipse(this.getX(), this.getY(), 15, 15);
    //line(this.getX(), this.getY(), this.getX(), this.getY() + 6);
    popMatrix();
    //stroke(255);
    //strokeWeight(2);
    //line(this.getX(), this.getY(), this.getTarX(), this.getTarY());
  }
}