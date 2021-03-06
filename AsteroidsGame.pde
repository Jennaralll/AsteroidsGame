ArrayList<Asteroids> rocks = new ArrayList<Asteroids>();
SpaceShip trek = new SpaceShip();
Star[] rats;
ArrayList<Bullet> pew = new ArrayList<Bullet>();
int score = 0; 
int health = 100;

public void setup() 
{
  size(600, 600);
  background(80, 60, 100);
  // rocks = new Asteroids[15];
  rats = new Star[(int)(Math.random()*200+100)];
  for(int i = 0; i<rats.length; i ++){
    rats[i] = new Star();
  }
  for(int i = 0; i < 10; i ++){
    rocks.add(new Asteroids());
  }
}

public void keyTyped(){
  if (key == 'h') {
    trek.setX((int)(Math.random()*600+1));
    trek.setY((int)(Math.random()*600+1));
    trek.setDirectionX(0);
    trek.setDirectionY(0);
    trek.setPointDirection((int)(Math.random()*360));
  }
  if(key == 'a'){
    trek.rotate(15);
  }
  if(key == 'd'){
    trek.rotate(-15);
  }
  if(key == 'w'){
    trek.accelerate(0.1);
  }
  if(key == 's'){
    trek.accelerate(-0.1);
  }
  if(key == ' '){
    pew.add(new Bullet());    
  }
  if(key == 'r'){
    score =0;
    health = 100;
  }
}

public void draw() {  
  background(75, 60, 100); //80, 60, 100
  trek.show(health, 5);
  trek.move();
  for (Star stars : rats)
    {
      stars.show();
  }
  for(int i = 0; i<rocks.size(); i ++){
    rocks.get(i).show();
    rocks.get(i).move();
  }
  for(int i = 0; i < rocks.size(); i ++) { //distance between rock and ship
    if(dist(trek.getX(), trek.getY(), rocks.get(i).getX(), rocks.get(i).getY()) < 20){
      rocks.remove(i);
      rocks.add(new Asteroids());
      if(health > 0){
        health -= 10;
      }
    }
  }
  for(int i = 0; i < pew.size(); i ++){
    pew.get(i).show();
    pew.get(i).move();
  }
  for(int p = 0; p < pew.size(); p ++) { //distance between asteroid and bullet
    for(int i = 0; i < rocks.size(); i ++){
        if(dist(pew.get(p).getX(), pew.get(p).getY(), rocks.get(i).getX(), rocks.get(i).getY()) < 20){
          rocks.remove(i);
          score ++;
          rocks.add(new Asteroids());
          pew.remove(p);
          break;
        }
    }
  }
  fill(255, 255,255);
  textSize(20);
  text("Score: " + score, 500, 40);
  if(score > 49){
    textSize(50);
    trek.setDirectionX(0);
    trek.setDirectionY(0);
    text("You win!", 200, 300);                
  }
}

class SpaceShip extends Floater  
{   
  public void setX(int x){
    myCenterX = x;
  }
  public int getX(){
    return (int)myCenterX;
  }
  public void setY(int y){
    myCenterY = y; 
  }
  public int getY(){
    return (int)myCenterY;
  }
  public void setDirectionX(double x){
    myDirectionX = x;
  }
  public double getDirectionX(){
    return myDirectionX;
  }
  public void setDirectionY(double y){
    myDirectionY = y;
  }
  public double getDirectionY(){
    return myDirectionY;
  }
  public void setPointDirection(int degrees){
    myPointDirection = degrees;
  }
  public double getPointDirection(){
    return myPointDirection;
  }

  public SpaceShip(){
    corners = 4;
    int[] xS = {-8, 16, -8, -6};
    int[] yS = {-8, 0, 8, 0};
    xCorners = xS; 
    yCorners = yS;
    myCenterX = 300;
    myCenterY = 300;
    myDirectionX = 0;
    myDirectionY = 0; 
    myPointDirection = 0;
    myColor = 255;
  }
  public void show(int w, int h){
    // rect(trek.getX() -50, trek.getY() - 25, w, h);
    if(health > 50){
      fill(0, 255, 0);
      rect(trek.getX() -50, trek.getY() - 25, w, h);
    }
    if(health <= 50){
      fill(255, 255, 0);
      rect(trek.getX() -50, trek.getY() - 25, w, h);
    }
    if(health < 30){
      fill(255, 0, 0);
      rect(trek.getX() -50, trek.getY() - 25, w, h);
    }
    if(health == 0){
      fill(255, 255, 255);
      textSize(25);
      text("You Lose! Press 'r' to restart (;", 100, 300);
    }
  super.show();
  }
}

class Asteroids extends Floater
{
  private int rotSpeed;
  public void setX(int x){
    myCenterX = x;
  }
  public int getX(){
    return (int)myCenterX;
  }
  public void setY(int y){
    myCenterY = y; 
  }
  public int getY(){
    return (int)myCenterY;
  }
  public void setDirectionX(double x){
    myDirectionX = 0;
  }
  public double getDirectionX(){
    return myDirectionX;
  }
  public void setDirectionY(double y){
    myDirectionY = 0;
  }
  public double getDirectionY(){
    return myDirectionY;
  }
  public void setPointDirection(int degrees){
    myPointDirection = 0;
  }
  public double getPointDirection(){
    return myPointDirection;
  }

  public Asteroids(){
    rotSpeed = (int)(Math.random()*11-5);
    corners = 6;
    int[] xS = {-11, 7, 10, 6, -10, -10};
    int[] yS = {-8, -8, 0, 10, 8, 0};
    xCorners = xS;
    yCorners = yS;
    myCenterX = (int)(Math.random()*600);
    myCenterY = (int)(Math.random()*600);
    myColor = color(210, 167, 210); //210, 167, 210
    myDirectionX = (int)(Math.random()*11 - 3);
    myDirectionY = (int)(Math.random()*11 - 3);
  }

  public void move(){
    rotate(rotSpeed);
    super.move();
  }
}

//background stars
class Star {
  int starX, starY;
  float starSize;
  public Star(){
    starX = (int)(Math.random()*600);
    starY = (int)(Math.random()*600);
    starSize = 1.5;
  }
  public void show(){
     noStroke();
     fill(255);
     ellipse(starX, starY, starSize, starSize);
  }
}


abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;   
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

