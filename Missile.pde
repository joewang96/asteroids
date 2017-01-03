class Missile extends Projectile {
  
  // super constructor and defining speed for the missile
  public Missile(int x, int y, float theta) {
    super(x, y, theta);
    this.setSpeed(6);
  }
  
  void display() {
    fill(255);
    //noStroke();
    stroke(255);
    ellipseMode(CENTER);
    pushMatrix();
    translate(width/2, height/2); 
    rotate(this.getTheta() - (PI/2)); // rotate the canvas
    //ellipse(this.getX(), this.getY(), 5, 5);
    line(this.getX(), this.getY(), this.getX(), this.getY() + 6);
    
    /** -- Text used to figure out if trueX and trueY are working
    fill(255);
    textAlign(CENTER);
    textSize(15);
    text("x: " + this.getTrueX() + " y: " + this.getTrueY(), this.getX(), this.getY() );
    **/
    
    popMatrix();
    //stroke(255);
    //strokeWeight(2);
    //line(this.getX(), this.getY(), this.getTarX(), this.getTarY());
  }
}