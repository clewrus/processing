
class Pixel{
  
  Pixel(float r, float g, float b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  Pixel(color c){
    this.r = red(c);
    this.g = green(c);
    this.b = blue(c);
  }
  
  Pixel(float b){
    this.r = b;
    this.g = b;
    this.b = b;
  }
  
  Pixel(){
    this.r = 0;
    this.g = 0;
    this.b = 0;
  }
  
  public Pixel copy(){
    return new Pixel(r, g, b);
  }
  
  public color toColor(){
    return color(r, g, b);
  }
  
  public float getBrightness(){
    return 0.299 * r + 0.587 * g + 0.114 * b;
  }
  
  public float r(){
    return r;
  }
  
  public float g(){
    return g;
  }
  
  public float b(){
    return b;
  }
  
  public void setColor(float r, float g, float b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
   public void setColor(float b){
    this.r = b;
    this.g = b;
    this.b = b;
  }
  
  public float setR(float r){
    return this.r = r;
  }
  
  public float setG(float g){
    return this.g = g;
  }
  
  public float setB(float b){
    return this.b = b;
  }
  
  private float r;
  private float g;
  private float b;
  
}