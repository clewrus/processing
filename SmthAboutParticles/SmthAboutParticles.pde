
Particle[] particle;
PVector[]forceDist;
int NUMBER_OF_PARTICLES = 2000;
boolean velsUpdated = false;
ArrayList<PVector> forceDot;
float MAX_FORCE = 20;

PVector buttonCenter;
int BUTTON_RADIUS = 50;

void setup(){
  size(500, 500);
  forceDot = new ArrayList<PVector>();
  forceDot.add( new PVector(width/2, height/2) );
  particle = new Particle[NUMBER_OF_PARTICLES];
  forceDist = new PVector[width * height];
  
  for(int i = 0; i < NUMBER_OF_PARTICLES; i++){
    particle[i] = new Particle();
  }
  
  //crating a button
  buttonCenter = new PVector(width - BUTTON_RADIUS - 10, height - BUTTON_RADIUS - 10);
  
}

void updateVel(){
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){

      forceDist[y * width + x] = new PVector(0, 0);
      
      for(int i = 0; i < (int)forceDot.size(); i++){
        PVector currFDot = forceDot.get(i);
        
        float currX = currFDot.x - x;
        float currY = currFDot.y - y;
        PVector currVec = new PVector(currX, currY);
        float contedForce = 10/pow(currVec.mag(), 1.2);
        if(contedForce > MAX_FORCE){
          contedForce = MAX_FORCE;
        }
        currVec.setMag( contedForce );
        forceDist[y * width + x].add(currVec);
      }
    }
  }
}

void showParticles(){
  for(int i = 0; i < particle.length; i++){
    particle[i].show();
  }
}

void aplyForce(){
  for(int i = 0; i < particle.length; i++){
    int currX = (int)particle[i].x;
    int currY = (int)particle[i].y;
    if(currX >= width || currX <= 0 || currY >= height || currY <= 0){
      particle[i].x -= particle[i].velX;
      particle[i].y -= particle[i].velY;
      particle[i].velX = particle[i].velY = 0;
    }
    int forceInd = (int)particle[i].y * width + (int)particle[i].x;
    particle[i].updateVel(forceDist[forceInd]);
  }
}

void mouseClicked(){
  if(dist(mouseX, mouseY, buttonCenter.x, buttonCenter.y) < BUTTON_RADIUS){
    forceDot = new ArrayList<PVector>();
  }else{
    forceDot.add( new PVector(mouseX, mouseY) );
  }
  velsUpdated = false;
}

void draw(){
  background(255);
  
  //showing button
  ellipse(buttonCenter.x, buttonCenter.y, BUTTON_RADIUS*2, BUTTON_RADIUS*2);
  
  showParticles();
  
  for(PVector atractPoint: forceDot){
    ellipse(atractPoint.x, atractPoint.y, 10, 10);
  }
  if(!velsUpdated){
    updateVel();
    velsUpdated = true;
  }
  aplyForce();
  
}