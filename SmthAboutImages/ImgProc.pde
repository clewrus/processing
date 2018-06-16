import java.util.Arrays;
import java.util.Comparator;

class ImgProc extends PixelImage{
  
  ImgProc(PImage img){
    super(img);
  }
  
  ImgProc(PixelImage img){
    super(img);
  }
  
  public PImage getImage(){
    return toPImage();
  }
  
  public void blackAndWhite(){
    
    for(int i = 0; i < len; i++){
      getPixel(i).setColor( getBrightness(i) );
    }
  }
  
  public PixelImage toPixelImage(){
    return new PixelImage(this);
  }
  
  public void autoContrast(){
    float min = 300;
    float max = -300;
    for(int i = 0; i < len; i++){
      if(getBrightness(i) > max){
        max = getBrightness(i);
      }
      if(getBrightness(i) < min){
        min = getBrightness(i);
      }
    }
    for(int i = 0; i < len; i++){
      float bright = getBrightness(i);
      setBrightness(i, (bright - min)*255/max);
    }
  }
  
  public PixelImage findDifference(PixelImage img){
    if(img.getWidth() != width_ || img.getHeight() != height_){
      println("smth is wrong");
      return null;
    }    
    PixelImage result = new PixelImage(this);
    float maxBrightness = -10000;
    float minBrightness = 10000;
    for(int i = 0; i < this.len; i++){
      Pixel resPixel = new Pixel(img.getBrightness(i) - this.getBrightness(i));
      result.setPixel(i, resPixel);
      
      if(resPixel.r() > maxBrightness){
        maxBrightness = resPixel.r();
      }
      if(resPixel.r() < minBrightness){
        minBrightness = resPixel.r();
      }
    }
    println(maxBrightness, minBrightness);
    maxBrightness -= minBrightness;
    for(int i = 0; i < this.len; i++){
      float bright = (result.getPixel(i).r() - minBrightness);
      bright *= 255.0 / maxBrightness;
      result.setPixel(i, new Pixel(bright));
    }
    return result;
  }
  
  public void medianFilter(int width_){
    PixelImage result = new PixelImage(this);
    for(int x = width_ / 2; x < this.width_ - (width_ / 2); x++){
      for(int y = width_ / 2; y < this.height_ - (width_ / 2); y++){
        Pixel[] pix = new Pixel[width_ * width_];
        for(int i = 0; i < width_ * width_; i++){
          int iX = i % width_ - width_ / 2;
          int iY = i / width_ - width_ / 2;
          pix[i] = getPixel(iX + x, iY + y).copy();
        }
        
        Arrays.sort(pix, new Comparator<Pixel>(){
          public int compare(Pixel p1, Pixel p2){
            float brightness1 = (p1.r() + p1.g() + p1.b() ) * 1000 / 3;
            float brightness2 = (p2.r() + p2.g() + p2.b() ) * 1000 / 3;
            return (int)(brightness1 - brightness2);
          }
        });
        result.setPixel(x, y, pix[width_ * width_ / 2]);
      }
    }
    pixArr = result.getPixArr();
  }
  
  public void smoothG(int width_, float sigma){
    if(width_ % 2 == 0 || width_ < 3){
      println("Smth wrong");
      return;
    }
    float filter[] = makeGaussMatrix(width_, sigma);

    PixelImage stageOne = new PixelImage(this);
    for(int x = width_ / 2; x < this.width_ - (width_/2); x++){
      for(int y = 0; y < this.height_; y++){
        Pixel nwPix = new Pixel();
        for(int i = 0; i < width_; i++){
          Pixel procPix = getPixel(i + x - width_ / 2, y);
          nwPix.setR(nwPix.r() + procPix.r() * filter[i]);
          nwPix.setG(nwPix.g() + procPix.g() * filter[i]);
          nwPix.setB(nwPix.b() + procPix.b() * filter[i]);
        }
        stageOne.setPixel(x, y, nwPix);
      }
    }
    
    for(int y = width_ / 2; y < this.height_ - (width_/2); y++){
      for(int x = 0; x < this.width_; x++){
        Pixel nwPix = new Pixel();
        for(int i = 0; i < width_; i++){
          Pixel procPix = stageOne.getPixel(x, i + y - width_ / 2);
          nwPix.setR(nwPix.r() + procPix.r() * filter[i]);
          nwPix.setG(nwPix.g() + procPix.g() * filter[i]);
          nwPix.setB(nwPix.b() + procPix.b() * filter[i]);
        }
        setPixel(x, y, nwPix);
      }
    }
  }
  
  private float[] makeGaussMatrix(int width_, float sigma){
    float[] filt = new float[width_];
    float step = (6 * sigma) / width_;
    float halfOfNumber = (width_ - 1) / 2;
    for(int i = 0; i < width_; i++){
      filt[i] = GaussDist( (i - halfOfNumber) * step, sigma);
    }
    float sum = 0;
    for(int i = 0; i < filt.length; i ++){
      sum += filt[i];
    }
    for(int i = 0; i < filt.length; i ++){
      filt[i] /= sum;
    }
    return filt;
  }
  
  private float GaussDist(float x, float sigma){
    return ( 1 / ( sigma * 2.50667 ) ) * exp( -pow(x / sigma, 2) / 2 );
  }
}