class Bird extends Element{
  Bird(){
    super();
    pos = new PVector(X_POS, height / 2);
    vel = new PVector(0, 0);
  }
  
  public void show(){
    ellipseMode(RADIUS);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  public void update(){
    vel.add(gravity);
    pos.add(vel);
    if(pos.y <= radius){
      pos.y = radius;
      vel.y = 0;
    }
  }
  
  public void push(){
    vel.add(pushPower);
  }
  
  public PVector getPosition(){
    return pos;
  }
  
  public int getRadius(){
    return radius;
  }
  
  public void setGravity(PVector gravity){
    this.gravity = gravity;
  }
  
  public void setPushPower(PVector pushPower){
    this.pushPower = pushPower;
  }
  
  public void setBirdRadius(int radius){
    this.radius = radius;
  }
  
  private int X_POS = width / 4;
  private int radius = 20;
  private PVector gravity = new PVector(0, 0.6);
  private PVector pushPower = new PVector(0, -18);
  private PVector pos;
  private PVector vel;
}