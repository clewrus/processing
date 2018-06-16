class Ball{
  Ball(float x, float y, int radius, float mass){
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.mass = mass;
    this.vel = new PVector(0, 0);
  }
  
  void aplyForce(PVector f){
    PVector a = f.mult(1 / mass);
    vel.add(a);
    print("F ");println(vel);
  }
  
  void aplyGravity(){
    aplyForce(new PVector(0, G));
    print("G ");println(vel);
  }
  
  void makeMove(){
    x += vel.x;
    y += vel.y;
  }
  
  void show(){
    ellipse(x, y, radius * 2, radius * 2);
  }
  
  void setG(float G){
    this.G = G;
  }
  
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  
  private float G = 0.01;
  
  private float x;
  private float y;
  private float mass;
  private int radius;
  private PVector vel;
}