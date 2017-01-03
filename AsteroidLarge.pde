class AsteroidLarge extends Asteroid {
  
  public AsteroidLarge(int x, int y, PVector vel) {
    super(x, y, vel, 75);
  }
  
  protected void display() {
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(this.getX(), this.getY(), this.getSize(), this.getSize());
    
    /** -- Text to determine if the coordinates were correct
    fill(255);
    textAlign(CENTER);
    textSize(15);
    text("x: " + this.getX() + " y: " + this.getY(), this.getX(), this.getY() );
    **/
  }
}