// This is going to be the parent class for Missile and Bomb
// It is abstract because I don't want to ever instantiate just a projectile, I want
// to make either a missile or bomb
abstract class Projectile {
  
  private float x, y; // the position of the projectile
  private final float theta;
  private float speed; // the speed of the projectile (gonna be 1 for missile, 
                      //like .7 for bomb)
                      
  public Projectile(int x, int y, float theta) {
    this.x = x;
    this.y = y;
    this.theta = theta;
    // have the subclasses define speed here
  }
  
  // getter for x
  public float getX() {
    return this.x;
  }
  
  // getter for y
  public float getY() {
    return this.y;
  }
  
  // getter for theta
  public float getTheta() {
    return this.theta;
  }
  
  // getter for speed
  public float getSpeed() {
    return this.speed;
  }
  
  // setter for x
  public void setX(float x) {
    this.x = x;
  }
 
  // setter for y
  public void setY(float y) {
    this.y = y;
  }
  
  // setter for y
  public void setSpeed(int s) {
    this.speed = s;
  }
  
  // draws the projectile
  abstract void display();
  
  // moves the projectile in the direction of its target (changes the x and y,
  // doesn't change what is being drawn
  protected void move() {
    this.setY(this.getY() + this.getSpeed());
  }
  
  boolean offScreen(int wid, int hei) {
    return this.getTrueX() < 0 || this.getTrueX() > wid 
    || this.getTrueY() < 0 || this.getTrueY() > hei;
  }
  
  // returns the true x-coordinate based off of y distance and rotation
  public float getTrueX() {
    float answer;
    if (this.theta >= 0 && this.theta <= PI/2 ) { // quadrant 1 (bottom right)
      answer = width/2 + (this.y * cos(this.theta));
    }
    else if (this.theta > PI/2 && this.theta <= PI) { // quadrant 2 (bottom left)
      answer = width/2 + (this.y * cos(this.theta));
    }
    else if (this.theta > -PI && this.theta <= -PI/2) { // quadrant 3 (top left)
      answer = width/2 + (this.y * cos(this.theta));
    }
    else { // (this.theta > -PI/2 && this.theta < 0) quadrant 4 (top right)
      answer = width/2 + (this.y * cos(this.theta));
    }
    return answer;
  }
  
  // returns the true y-coordinate based off of y distance and rotation
  public float getTrueY() {
    float answer;
    if (this.theta >= 0 && this.theta <= PI/2 ) { // quadrant 1 (bottom right)
      answer = height/2 + (this.y * sin(this.theta));
    }
    else if (this.theta > PI/2 && this.theta <= PI) { // quadrant 2 (bottom left)
      answer = height/2 + (this.y * sin(this.theta));
    }
    else if (this.theta > -PI && this.theta <= -PI/2) { // quadrant 3 (top left)
      answer = height/2 + (this.y * sin(this.theta));
    }
    else { // (this.theta > -PI/2 && this.theta < 0) quadrant 4 (top right)
      answer = height/2 + (this.y * sin(this.theta));
    }
    return answer;
  }
  
  // tells if the projectile has hit an asteroid
  boolean hitAsteroid(Asteroid ast) {
    int astX = ast.getX();
    int astY = ast.getY();
    int astSize = ast.getSize();
    return ((this.getTrueX() >= astX - astSize/2 
    && this.getTrueX() <= astX + astSize/2)) 
    && ((this.getTrueY() >= astY - astSize/2 
    && this.getTrueY() <= astY + astSize/2));
  }
}