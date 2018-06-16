float r = 300;
float rv = 0;
float ra = 0;
float a = 0;
float av = 0.005;
float aa = 0;
float dt = 0.00001;
float gm = 2030;

PGraphics layout;

void setup(){
  size(600, 600);
  layout = createGraphics(width, height);
  layout.beginDraw();
  layout.background(150);
  layout.endDraw();
}

void draw(){
  layout.beginDraw();
  layout.translate(width / 2, height / 2);
  layout.ellipse(0, 0, 20, 20);
  layout.ellipse(r * cos(a), r * sin(a), 10, 10);
  layout.endDraw();
  
  background(layout);
  
  text(rv, 20, 20);
  
  for(int i = 0; i < 15000; i++){
    ra = av * av * r - gm / (r * r);
    aa = -2 * rv * av / r;
    rv += ra * dt;
    r += rv * dt;
    av += aa * dt;
    a += av * dt;
    if(abs(a) > TWO_PI){
      a = a - TWO_PI * a / abs(a);
    }
  }
}