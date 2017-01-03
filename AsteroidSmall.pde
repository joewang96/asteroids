class AsteroidSmall extends Asteroid {
  
  public AsteroidSmall(int x, int y, PVector vel) {
    super(x, y, vel, 30);
  }
  
  protected void display() {
    noFill();
    stroke(40, 246, 239); // blue-ish
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