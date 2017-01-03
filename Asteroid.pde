abstract class Asteroid {
  
  private int x, y;
  private final PVector vel;
  private final int size;
  
  public Asteroid(int x, int y, PVector vel, int size) {
    this.x = x;
    this.y = y;
    this.vel = vel;
    this.size = size;
  }
  
  // getter for x
  public int getX() {
    return this.x;
  }
  
  // getter for y
  public int getY() {
    return this.y;
  }
  
  // getter for vel
  public PVector getVel() {
    return this.vel;
  }
  
  // getter for size
  public int getSize() {
    return this.size;
  }
  
  // setter for x
  public void setX(int x) {
    this.x = x;
  }
  
  // setter for y
  public void setY(int y) {
    this.y = y;
  }
  
  // draw the asteroid
  protected abstract void display();
  
  // move the asteroid based on its velocity
  protected void move() {
    this.x += this.vel.x;
    this.y += this.vel.y;
  }
  
  protected boolean offScreen() {
    return this.getX() < 0 || this.getX() > width || 
    this.getY() < 0 || this.getY() > height;
  }
  
  // checks if it hit the player
  protected boolean hitPlayer(int px, int py) {
    return (( px > this.x - this.size/2 && px < this.x + this.size/2)) &&
           ((py > this.y - this.size/2 && py < this.y + this.size/2));
  }
}