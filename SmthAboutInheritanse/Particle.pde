
abstract class Particle{
  Particle(){
    friction = 0.99f;
    vel = PVector.random2D();
    vel.mult(random(5) + 1);
    pos = new PVector();
    pos.x = random(width);
    pos.y = random(height);
  }
  
  public void update(){
    vel.add(g);
    PVector p = new PVector(mouseX, mouseY);
    p.sub(pos);
    p.normalize();
    vel.add(p);
    vel.mult(friction);
    pos.add(vel);
    if(pos.x > width || pos.x < 0){
      vel.x *= -1;
    }
    
    if(pos.y > height || pos.y < 0){
      vel.y *= -1;
    }
  }
  
  public void say(){
    println("Particle");
  }
  
  public abstract void show();
  
  void setFriction(float friction){    
    this.friction = friction;
    println(friction);
  }
  
  protected PVector pos;
  private PVector vel;
  private PVector g = new PVector(0, 0.1);
 
  private float friction;
}