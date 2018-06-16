
class BinaryImage{
  BinaryImage(int width_, int height_){
    initialize(width_, height_);
  }
  
  BinaryImage(){}
  
  protected void initialize(int width_, int height_){
    this.width_ = width_;
    this.height_ = height_;
    len = width_ * height_;
    pixArr = new boolean[width_ * height_];
  }
  
  protected int[] getNeighborI(int curI, int widt){
    return getNeighborI(curI, widt, widt);
  }
  
  protected int[] getNeighborI(int curI, int widt, int heigh){
    int[] neighbors = new int[9];
    for(int i = 0; i < 9; i++){
        int X = curI % widt + i % 3 - 1; 
        int Y = curI / widt + i / 3 - 1;
        X = (X >= 0)? (X < widt)? X: widt - 1 : 0;
        Y = (Y >= 0)? (Y < heigh)? Y: heigh - 1 : 0;
        int curIndex = Y * widt + X;
        neighbors[i] = curIndex;
    }
    return neighbors;
  }
 
  public void trasholdBinarization(PixelImage img, float treshold, boolean flag){
    for(int i = 0; i < len; i++){
      if(img.getBrightness(i) > treshold){
        pixArr[i] = flag;
      }else{
        pixArr[i] = !flag;
      }
    }
  }
  
  public void otsuBinarization(PixelImage img, boolean flag){
    Integer[] hyst = img.getHystogram();
    int N = img.getLength();
    double M;
    Double[] w = new Double[hyst.length];
    Double[] m = new Double[hyst.length];

    w[0] = 1.0D * hyst[0];
    m[0] = 1.0D * hyst[0];
    M = m[0];
    for(int i = 1; i < hyst.length; i++ ){
      w[i] = w[i - 1] + hyst[i];
      w[i - 1] /= N;
      
      m[i] = m[i - 1] + hyst[i] * (i + 1);
      M = m[i];
      m[i - 1] /= N * w[i - 1];
    }
    w[hyst.length - 1] /= N;
    m[hyst.length - 1] /= N * w[hyst.length - 1];
    M /= N;
    
    double maxSigma = 0;
    double bestTrashold = 0;
    for(int i = 0; i < hyst.length; i++){
      double w1 = w[i];
      double w2 = 1 - w1;
      
      double m1 = m[i];
      double m2 = (M - m1 * w1) / w2;
      
      double curSigma = w1 * w2 * (m1 - m2) * (m1 - m2);
      if(curSigma >= maxSigma){
        maxSigma = curSigma;
        bestTrashold = i;
      }
    }
    this.trasholdBinarization(img, (float)bestTrashold, flag);
  }
  
  public PImage toPImage(int width_, int height_){
    PImage curImg = toPImage();
    curImg.resize(width_, height_);
    return curImg;
  }
  
  public PImage toPImage(){
    PImage result = new PImage(width_, height_);
    result.loadPixels();
    for(int i = 0; i < result.pixels.length; i++){
      result.pixels[i] = (pixArr[i])? color(255) : color(0);
    }
    return result;
  }
  
  public void setPixArr(boolean[] arr){
    pixArr = arr;
  }
  
  public int getWidth(){
    return width_;
  }
  public int getHeight(){
    return height_;
  }
  public int getLength(){
    return len;
  }
  public boolean[] getPixArr(){
    boolean[] cpy = new boolean[len];
    for(int i = 0; i < len; i++){
      cpy[i] = pixArr[i];
    }
    return cpy;
  }
  
  protected boolean[] pixArr;
  protected int width_;
  protected int height_;
  protected int len;
}