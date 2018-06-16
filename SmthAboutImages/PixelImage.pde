
class PixelImage{
  
  PixelImage(PImage img){
    this.initialImage = img.copy();
    this.len = img.width * img.height;
    
    this.width_ = img.width;
    this.height_= img.height;
    
    pixArr = new Pixel [len];
    restoreImage();
  }
  
  PixelImage(PixelImage img){
    this.initialImage = img.getInitialImg();
    this.width_ = img.getWidth();
    this.height_ = img.getHeight();
    this.pixArr = img.getPixArr();
    this.len = width_ * height_;
  }
  
  protected void restoreImage(){
    for(int i = 0; i < len; i++){
      pixArr[i] = new Pixel(initialImage.pixels[i]);
    }
  }
  
  public float getAvBrightness(){
    double sum = 0;
    for(int i = 0; i < len; i++){
      sum += getBrightness(i);
    }
    return (float)(sum / len);
  }
  
  public PImage toPImage(int width_, int height_){
    PImage img = toPImage();
    img.resize(width_, height_);
    return img;
  }
  
  public PImage toPImage(){
    PImage p = new PImage(width_, height_);
    p.loadPixels();
    
    for(int i = 0; i < len; i++){
      p.pixels[i] = pixArr[i].toColor();
    }
    
    p.updatePixels();
    return p;
  }
  
  protected void setBrightness(int i, float brightness){
    setBrightness(i % width_, i / width_, brightness);
  }
  
  protected void setBrightness(int x, int y, float brightness){
    Pixel p = getPixel(x, y);
    float curBrightness = getBrightness(x, y);
    float k;
    if( curBrightness != 0.0 ){
      k =  brightness / curBrightness;
    }else{
      k = 0;
    }
    p.setColor(p.r()*k, p.g()*k, p.b()*k);
  }
  
  public PImage getInitialImg(){
    return initialImage.copy();
  }
  
  public Integer[] getHystogram(){
    Integer[] hyst = new Integer[256];
    
    for(int i = 0; i < 256; i++){
      hyst[i] = 0;
    }
    
    for(Pixel i: pixArr){
      hyst[int( i.getBrightness() )]++;
    }
    return hyst;
  }
  
  public int getLength(){
    return pixArr.length;
  }
  
  public int getWidth(){
    return width_;
  }
  
  public int getHeight(){
    return height_;
  }
  
  public Pixel[] getPixArr(){
    Pixel[] pCopy = new Pixel[len];
    System.arraycopy(pixArr, 0, pCopy, 0, len);
    return pCopy;
  }
  
  protected float getBrightness(int x, int y){
    Pixel p = getPixel(x, y);
    return p.getBrightness();
  }
  
  protected float getBrightness(int i){
     Pixel p = pixArr[i];
    return p.getBrightness();
  }
  
  protected Pixel getPixel(int x, int y){
    return pixArr[width_ * y + x];
  }
  
  protected Pixel getPixel(int i){
    return pixArr[i];
  }
  
  protected void setPixel(int x, int y, Pixel p){
    pixArr[width_ * y + x] = p;
  }
  
  protected void setPixel(int i, Pixel p){
    pixArr[i] = p;
  }
  
  protected Pixel[] pixArr;
  protected PImage initialImage;
  protected int len;
  protected int width_;
  protected int height_;
}