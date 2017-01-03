// Joseph Wang
// ARTG 2260: Programming Basics
// Assignment 2

/*
For this assignment I made a variation on the game asteroid. I simplified it a bit by
not having the player be able to move around, however I also changed the controls so
that the player rotates based off of the mouse rather than the keyboard. Asteroids
randomly spawn at different sizes and move across the screen. The player must shoot
them in order to not get hit. If the player is hit then their health reduces by 1.
Note that unlike the original game the player does not "die" but rather they take
damage and their model flashes. The game is over once the player loses all of 
their lives.
*/

Player p; // the player's representation
int points; // the amount of points earned
ArrayList<Projectile> projectiles; // the projectiles fired by the player
ArrayList<Asteroid> asteroids; // the list of all asteroids
//ArrayList<Asteroid> asteroids; // the list of asteroids on screen
boolean gameOver, started; // tells if the game is over
int time; // the time aspect (determines when to add an asteroid)
int overlayTime; // the time for the overlay when player is hit
//int amtBombs; // the amount of bombs the player has
//int bmbTextTime; // the time used to show the "No bombs left" text

void setup() {
  size(650, 650);
  p = new Player();
  points = 0;
  this.gameOver = false;
  this.started = false;
  projectiles = new ArrayList<Projectile>();
  asteroids = new ArrayList<Asteroid>();
  time = 0;
  overlayTime = 0;
  //amtBombs = 5;
}

// shows the starting screen
void startScreen() {
  background(0); // clear the background
  // now for text instructions
  textAlign(CENTER);
  
  fill(247, 69, 137); // choose one of these colors
  textSize(60);
  text("ASTEROID", width/2, height/5.5);
  
  fill(255);
  textSize(40);
  text("Press 'Enter' to begin", width/2, height/3);
  
  textSize(25);
  text("Controls:", width/2, height/3 + height/10);
  
  textSize(20);
  text("Use mouse to rotate player", width/2, height/3 + (1.5*height/10));
  text("Press 'D' to shoot a missile, press 'F' to shoot a bomb", 
        width/2, height/3 + (2*height/10));
  text("Press 'R' to reset the game", width/2, height/3 + (2.5*height/10));
  text("If a player is hit they lose a life, game continues", width/2, 
        height/3 + (3*height/10));
  text("until all lives are lost", width/2, height/3 + (3.5*height/10));
  
  textSize(40);
  text("Best of luck!", width/2, height * 5 / 6);
}

// shows the starting screen
void endScreen() {
  background(0); // clear the background
  // now for text instructions
  textAlign(CENTER);
  
  fill(247, 69, 137); // choose one of these colors
  textSize(110);
  text("GAME OVER", width/2, height/2);
  
  fill(255);
  textSize(40);
  text("Want To Try Again?", width/2, height * 1.85/3);
  
  fill(220, 220, 220, 170);
  textSize(25);
  text("Press 'Enter' to restart", width/2, height * 2./3);
}

// draws the entire game state
void draw() {
  if (!this.started && !this.gameOver) {
    this.startScreen();
  }
  else if (this.gameOver) {
    this.endScreen();
  }
  else {
    background(0); // clear the background

    int myX, myY; // the location to translate to
    myX = (width/2);
    myY = (height/2);
    
    //this.displayAngle();  -- This was used for testing --
    this.checkAstHit();
    this.checkPlayerHit();
    this.checkHealth();
    this.handleTime();
    this.displayHealth(); // display the health of the player
    this.displayPoints(); // display the points the player has earned
    //this.displayBombAmount(); // displays the amount of bombs left
    this.displayPlayer(myX, myY);
    this.displayAllProjectiles();
    this.displayAllAsteroids();
    // the display out of bombs text
    /*
    if (bmbTextTime > 0) {
      this.showNoBombs();
    }
    */
  }
}

// draws the player
void displayPlayer(int x, int y) {
  pushMatrix(); // save the current transformation matrix
  translate(x, y); // move the origin
  float theta = atan2(mouseY-y, mouseX-x); // angle of rotation 
  rotate(theta+(PI/2)); // rotate the canvas
  p.display(); // display the object
  popMatrix(); // restore to the saved transformation matrix
}

// displays the health on screen
void displayHealth() {
  textAlign(LEFT);
  textSize(20);
  fill(255);
  text("Health: " + p.getHealth(), 10, 25);
}

// display the total points on screen
void displayPoints() {
  textAlign(RIGHT);
  textSize(20);
  fill(255);
  text("Points: " + this.points, width - 10, 25);
}

/*
// display the total points on screen
void displayAngle() {
  textAlign(LEFT);
  textSize(20);
  fill(255);
  float theta = atan2(mouseY- height/2 , mouseX- width/2); // angle of rotation 
  text("Theta: " + theta, 10, 50);
}

// display the total points on screen
void displayBombAmount() {
  textAlign(CENTER);
  textSize(20);
  fill(255);
  text("Bombs: " + amtBombs, width/2, 25);
}

void showNoBombs() {
  textAlign(CENTER);
  textSize(20);
  fill(255, 0, 0);
  text("[ NO BOMBS LEFT ]", width/2, 100);
}
*/

// shoots the missile and appends to the arrayList
void shootMissile() {
  pushMatrix();
  float theta = atan2(mouseY- width/2, mouseX- height/2); // angle of rotation 
  rotate(theta+(PI/2)); // rotate the canvas
  projectiles.add(new Missile(0, 0, theta));
  popMatrix();
}

/*
// shoots the bomb and appends to the arrayList
void shootBomb() {
  pushMatrix();
  float theta = atan2(mouseY- width/2, mouseX- height/2); // angle of rotation 
  rotate(theta+(PI/2)); // rotate the canvas
  projectiles.add(new Bomb(0, 0, theta));
  popMatrix();
  amtBombs -= 1;
}
*/

// adds an asteroid after a certain amount of time (make a time variable)
void addAsteroid() {
  pushMatrix();
  float rand = random(0, 3);
  float randX, randY;
  float randVelX, randVelY;
  float decideSide = random(0, 4);
  
  if (decideSide < 1) {
    // left wall
    randX = 5;
    randY = random(0, height);
  }
  else if (decideSide < 2) { // works cause we already checked < 1 so 1 < decideSide < 2
    // top wall
    randX = random(0, width);
    randY = 5;
  }
  else if (decideSide < 3) { // works cause we already checked < 2 so 2 < decideSide < 3
    // right wall
    randX = width - 5;
    randY = random(0, height);
  }
  else { // works cause we already checked < 3 so 3 < decideSide < 4
    // bottom wall
    randX = random(0, width);
    randY = height - 5;
  }
  
  // now to do some math to figure out the random velocity so the asteroids move
  // across the screen and not simply out of the screen
  if (randX > width/2) {
    randVelX = random(-5, -3);
  }
  else {
    randVelX = random(3, 5);
  }
  
  if (randY > height/2) {
    randVelY = random(-5, -3);
  }
  else {
    randVelY = random(3, 5);
  }
  
  // now to add the asteroids
  if (rand > 2) {
    this.asteroids.add(new AsteroidLarge(round(randX) , round(randY), 
    new PVector(ceil(randVelX), ceil(randVelY)) ));
  }
  else {
    this.asteroids.add(new AsteroidSmall(round(randX) , round(randY), 
    new PVector(ceil(randVelX), ceil(randVelY)) ));
  }
  popMatrix();
}

// draws all projectiles (missiles and bombs)
void displayAllProjectiles() {
  ArrayList<Integer> toRemove = new ArrayList(); // the projectiles to remove
  for (int i = 0; i < projectiles.size(); i++) {
    projectiles.get(i).display();
    projectiles.get(i).move();
    if (projectiles.get(i).offScreen(width, height)) { // checks to see if it should be removed
      toRemove.add(i);
    }
  }
  for (int j = 0; j < toRemove.size(); j++) {
    projectiles.remove(toRemove.get(j));
  }
}

// moves and displays the asteroids (have the asteroids have a move method and give
// them a starting velocity/direction and stuff
void displayAllAsteroids() {
  ArrayList<Integer> toRemove = new ArrayList(); // the ateroids to remove
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).display();
    asteroids.get(i).move();
    if (asteroids.get(i).offScreen()) { // checks to see if it should be removed
      toRemove.add(i);
    }
  }
  for (int j = 0; j < toRemove.size(); j++) {
    asteroids.remove(toRemove.get(j));
  }
}

// checks if player is hit and deals damage
void checkPlayerHit() {
  boolean hit = false;
  for (int i = asteroids.size() - 1; i > 0; i--) {
    if (this.asteroids.get(i).hitPlayer(width/2, height/2)) {
      this.asteroids.remove(i);
      this.p.setHealth(this.p.getHealth() - 1);
      hit = true;
    }
  }
  if (hit == true) {
    overlayTime = 10;
  }
}

// checks if a projectile hits an asteroid and destroys it
// destroys after checking entire list otherwise it would skip some
void checkAstHit() {
  ArrayList<Projectile> removePro = new ArrayList();
  for (int i = this.projectiles.size() - 1; i >= 0; i--) {
    for (int j = this.asteroids.size() - 1; j >= 0; j--) {
      if (this.projectiles.get(i).hitAsteroid(this.asteroids.get(j))) {
        removePro.add(this.projectiles.get(i)); // remove projectile
        this.asteroids.remove(j); // remove asteroid
        points += 1;
      }
    }
  }
  
  for (int i = 0; i < removePro.size(); i++) {
    this.projectiles.remove(removePro.get(i));
  }
}

// checks player health and ends game if health == 0
void checkHealth() {
  if (this.p.getHealth() == 0) {
    this.setup();
    this.gameOver = true;
    this.started = false;
  }
}

// checks key strokes for user input
void keyReleased() {
  switch (key) {
    case 'r':
      this.setup();
      break;
    /*
    case 'f':
      if (amtBombs > 0) {
        this.shootBomb();
      }
      else {
        bmbTextTime = 20;
      }
      break;
    */
    case 'd':
      this.shootMissile();
      break;
    case ENTER:
      if (!this.started) {
        this.started = true;
        this.gameOver = false;
      }
      break;
    case RETURN:
      if (!this.started) {
        this.started = true;
      }
      break;
  }
}

// handles the time aspect (increments and adds an asteroid on the given time)
void handleTime() {
  
  // the main timing for adding asteroids
  if (time == 25) {
    this.addAsteroid();
    time = 0;
  }
  else {
    time += 1;
  }
  
  // player is hit color change timings
  if (overlayTime > 0) {
    this.p.setColor(color(0) , color(10) );
    overlayTime -= 1;
  }
  else {
    this.p.revertColor();
  }
  
  /*
  // timing for the out of bombs text
  if (bmbTextTime > 0) {
    bmbTextTime -= 1;
  }
  */
}