class Player {
  
  private color f,s; // fill and stroke color
  private int health;
 
  // constructor for Player
  public Player() {
    f = color(0);
    s = color(247, 69, 137); // red-ish now, color(40, 246, 239); is the blue-ish color
    health = 3;
  }
  
  // draws the representation of the player 
  void display() {
    fill(f);
    stroke(s);
    strokeWeight(2);
    triangle(0, -20, 20, 20, -20, 20);
    
    /* 
    this gives a pointer so you know where it is pointing
    may or may not keep this, not sure how i like this
    fill(s);
    triangle(0, -20, 10, 0, -10, 0);
    */
  }
  
  // the "getter" for the player's health value
  public int getHealth() {
    return this.health;
  }
  
  // the "getter" for the player's health value
  public void setHealth(int h) {
    this.health = h;
  }
  
  // sets the color for fill and stroke
  public void setColor(color fill, color stroke) {
    this.f = fill;
    this.s = stroke;
  }
  
  // sets the color for fill and stroke
  public void revertColor() {
    this.f = color(0);
    this.s = color(247, 69, 137);
  }
  
  // check for contact with another object
  /*
  protected boolean isContact(int x, int y) {
  }
  */
}