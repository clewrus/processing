BinarySymbol[] symbols;
int num = 0;

void setup(){
  size(200, 200);
  background(120);
  PImage img = loadImage("task.png");
  img.resize(0, int(img.height/1.2));
  println(img.height, img.width);
  PixelImage pixelImage = new PixelImage(img);
  BinaryImage binImg = new BinaryImage(pixelImage.getWidth(), pixelImage.getHeight());
  binImg.otsuBinarization(pixelImage, true);
  BinImgProc proc = new BinImgProc(binImg);
  //image(proc.toPImage(), 0, -2000);
 
  
  println("starting");
  symbols = proc.parseSymbols();
  println("end");
    
  mouseClicked();
}

void draw(){
}


void mouseClicked(){
  PImage curIm = symbols[num++].toPImage();
  num %= symbols.length;
  background(120);
  text(num+1 + " / " + symbols.length, 0, 20);
  curIm.resize(0, 50);
  image(curIm, width/2 - curIm.width/2, height/2 - curIm.height/2);
}