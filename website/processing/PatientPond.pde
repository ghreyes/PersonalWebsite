/*
Patient Pond by Gabriel Reyes

Project done for Film 170A class in Spring 2017

INSTRUCTIONS
- Click to ping a point
- After a delay, a fish will swim toward the point you touched
- Once it reaches this point, it will no longer be affected by user input and will swim around
- Multiple clicks spawn multiple fishes

*/

//import java.util.Iterator;

ArrayList<PImage> fishImages = new ArrayList<PImage>();
ArrayList<TimePoint> timePoints = new ArrayList<TimePoint>();
ArrayList<Fish> fishList = new ArrayList<Fish>();
ArrayList<Ping> pingList = new ArrayList<Ping>();
WaterGif water;

//preload images for use in webpage
 /* @pjs preload="
 processing/data/AnimatedFish/fish0.png,
 processing/data/AnimatedFish/fish1.png,
 processing/data/AnimatedFish/fish2.png,
 processing/data/AnimatedFish/fish3.png,
 processing/data/AnimatedFish/fish4.png,
 processing/data/AnimatedFish/fish5.png,
 processing/data/AnimatedFish/fish6.png,
 processing/data/AnimatedFish/fish7.png,
 processing/data/AnimatedWater/water001.png,
 processing/data/AnimatedWater/water002.png,
 processing/data/AnimatedWater/water003.png,
 processing/data/AnimatedWater/water004.png,
 processing/data/AnimatedWater/water005.png,
 processing/data/AnimatedWater/water006.png,
 processing/data/AnimatedWater/water007.png,
 processing/data/AnimatedWater/water008.png,
 processing/data/AnimatedWater/water009.png,
 processing/data/AnimatedWater/water010.png,
 processing/data/AnimatedWater/water011.png,
 processing/data/AnimatedWater/water012.png,
 processing/data/AnimatedWater/water013.png,
 processing/data/AnimatedWater/water014.png,
 processing/data/AnimatedWater/water015.png,
 processing/data/AnimatedWater/water016.png,
 processing/data/AnimatedWater/water017.png,
 processing/data/AnimatedWater/water018.png,
 processing/data/AnimatedWater/water019.png,
 processing/data/AnimatedWater/water020.png,
 processing/data/AnimatedWater/water021.png,
 processing/data/AnimatedWater/water022.png,
 processing/data/AnimatedWater/water023.png,
 processing/data/AnimatedWater/water024.png,
 processing/data/logo.png"*/
 
void setup(){
  size(800, 800);
  imageMode(CENTER);
  ellipseMode(CENTER);
  frameRate(20);
  
  //PImage icon = loadImage("processing/data/logo.png");
  //surface.setIcon(icon);
    
  water = new WaterGif();
  
  File dir = new File("processing/data/AnimatedFish"));
  for(int i = 0; i < dir.list().length; i++){
    println("Loaded " + dir.list()[i]);
    fishImages.add(loadImage(dir + "\\" + dir.list()[i]));
  }
}

void draw(){
  water.display();

  if(timePoints.size() > 0){
    if(timePoints.get(0).time + 5000 < millis()){
      println(timePoints.get(0) + " spawned at " + millis());
      Fish newFish = new Fish();
      fishList.add(newFish);
      newFish.spawnLookingToward(timePoints.get(0).point);
      timePoints.remove(0);
    }
  }
  
  //draw fishes or remove if off screen
  /*Iterator<Fish> fishIter = fishList.iterator();
  while(fishIter.hasNext()){
    Fish fish = fishIter.next();
    if(fish.alive){
      fish.think();
      fish.swim();
    }
    else fishIter.remove();
  }*/
  
  for(int i = 0; i < fishList.size; i++){
  	if(fish.get(i).alive){
  	  fish.think();
  	  fish.swim();
	}
	else fishList.splice(i,1);
  }
  
  //draw ping or remove if time is up
  /*Iterator<Ping> pingIter = pingList.iterator();
  while(pingIter.hasNext()){
    Ping ping = pingIter.next();
    if(millis() <= ping.endTime){
      ping.display();
    } 
    else pingIter.remove();
  }*/
  
    for(int i = 0; i < pingList.size; i++){
  	if(pingList.get(i).endTime >= millis){
  	  pingList.get(i).display;
	}
	else pingList.splice(i,1);
  }
}

void mouseReleased(){
  //clicking adds a timePoint which will spawn a fish after a delay and displays a ping
  timePoints.add(new TimePoint(millis(), new Point(mouseX, mouseY)));
  pingList.add(new Ping(mouseX, mouseY));
}


//Ping displays concentric circles that pulse outwards until time is up
class Ping{
  Point point;
  int endTime;
  float outerScale;
  float innerSize = 10;
  
  Ping(int x, int y){
    point = new Point(x, y);
    endTime = millis() + 3500;
  }
  
  void display(){
    calcScale();
    
    fill(#1E50E3);
    ellipse(point.x, point.y, outerScale * innerSize, outerScale * innerSize);
    fill(#5677D6);
    ellipse(point.x, point.y, ((outerScale + 1)/2) * innerSize, ((outerScale + 1)/2) * innerSize);
    fill(#1E50E3);
    ellipse(point.x, point.y, innerSize, innerSize);
  }
  
  void calcScale(){
    outerScale += .1;
    if(outerScale >= 2) outerScale = 1;
  }
}


//Animation to be used for fish. Displays images in sequence
class Animation {
  ArrayList<PImage> images;
  int imageCount;
  int frame;
  
  Animation() {
    images = fishImages;
    imageCount = fishImages.size();
  }
  
  void display(float x, float y){
    frame = (frame+1) % imageCount;
    image(images.get(frame), x, y);
  }

  int getWidth(){
    return images.get(0).width; 
  }
  
  int getHeight(){
    return images.get(0).width;
  }
}


//WaterGif is animation for water. Loads images and displays in sequence
class WaterGif {
  File dir;
  ArrayList<PImage> waterImages;
  int imageCount;
  int frame;
  
  WaterGif() {
    waterImages = new ArrayList<PImage>();
    
    dir = new File("processing/data/AnimatedWater"));
    imageCount = dir.list().length;
    
    for(int i = 0; i < imageCount; i++){
      println("Loaded " + dir.list()[i]);
      PImage img = new PImage();
      img = loadImage(dir + "\\" + dir.list()[i]);
      img.resize(width, height);
      waterImages.add(img);
    }
  }
    
  void display(){
    frame = (frame+1) % imageCount;
    image(waterImages.get(frame), width/2, height/2);
  }
}


//Fish is the object for fish. Contains physics variables as well as spawn/despawn logic
class Fish {
  float x;
  float y;
  float speed;
  float rotation;
  boolean free;
  Point touch;
  int lastTimeMoved;
  float turnToward;
  boolean alive;
  Animation animation;
  float fishWidth;
  float fishHeight;
  
  Fish(){
    free = false;
    alive = true;
    speed = 4;
    lastTimeMoved = 0;
    turnToward = 0;
    
    animation = new Animation();
    fishWidth = animation.getWidth();
    fishHeight = animation.getHeight();
  }
  
  void spawnLookingToward(Point p){
    int pick = floor(random(4));
    touch = p;

    //Spawn at a different off-screen location based off of random int (pick)
    //right
    if(pick == 0){
      x = width + random(width/2);
      y = -(height/2) + random(2 * width);
    }
    //left
    if(pick == 1){
      x = 0 - random(width/2);
      y = -(height/2) + random(2 * width);
    }
    //up
    if(pick == 2){
      x = -(width/2) + random(2 * width);
      y = 0 - random(height/2);
    }
    //down
    if(pick == 3){
      x = width + random(width/2);
      y = height + random(height/2);
    }
        
    //look toward point
    rotation = degrees(atan2(p.y - y, p.x - x));
  }
    
  
  void swim(){
    x = x + (speed * cos(radians(rotation)));
    y = y + (speed * sin(radians(rotation)));

    pushMatrix();
    translate(x - (fishWidth/2), y - (fishHeight/2));
    rotate(radians(rotation));
    animation.display(0,0);
    popMatrix();
  }
  
  
  void think(){
    //don't think if swimming toward point
    if(!free){
      //if close to point, become free
      if(abs(dist(touch.x, touch.y, x, y)) < 10) free = true;
    }
    else {
      if(millis() - lastTimeMoved > 1000){
        lastTimeMoved = millis();
        turnToward = random(360);
      }
      
      turn(turnToward);
      
      //if facing near turnToward, speed is higher
      if(abs(turnToward - rotation) < 15){
        if(speed < 5) speed += .1;
      }
      else if (speed > 2) speed -= .1;
      
      //if off screen, stop functionality
      if(x > (width + 2*fishWidth) || x < -2*fishWidth || y > (height + 2*fishHeight) || y < -2*fishHeight)
        alive = false;
    }
  }
  
  void turn(float tt){
    if(rotation < 0) rotation += 360;
    if(tt > rotation) rotation += .05*(tt - rotation);
    if(tt < rotation) rotation -= .05*(rotation - tt);
  }
}


//Point is a simple (x, y) coodinate point
class Point{
  int x;
  int y;
  
  Point(int initX, int initY){
    x = initX;
    y = initY;
  }
  
  String toString(){
    return "(" + x + "," + y + ")";
  }
}


//TimePoint is an object used for spawning fish 
//Time = time clicked  
//Point = click location
class TimePoint{
  int time;
  Point point;
  
  TimePoint(int t, Point p){
    time = t;
    point = p;
  }
  
  String toString(){
    return ("Time: " + time + " Point: " + point);
  }
}