class Particle{
  Particle(){
    x = random(width);
    y = random(height);
    velX = 0;
    velY = 0;
  }
  
  public void show(){
    ellipse(x, y, 4, 4);
  }
  
  public void updateVel(PVector force){
    velX += force.x;
    velY += force.y;
    
    velX *= 0.98;
    velY *= 0.98;
    
    x += velX;
    y += velY;
  }
  
  public float velX;
  public float velY;
  
  public float x;
  public float y;
}