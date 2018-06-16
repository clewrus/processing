double a1 = map(55, 0, 100, -PI, PI);
double a2 = a1;
double v1 = 0;
double v2 = 0;
double dt = 0.00001;
double k = 10;  // g / l
float l = 200;


void setup(){
  size(500, 500);
  
}

void drawPendulum(double x){
  ellipse(0, 0, 10, 10);
  float nwX = l * sin((float)x);
  float nwY = l * cos((float)x);
  line(0, 0, nwX, nwY);
  ellipse(nwX, nwY, 25, 25);
}

void draw(){
  background(150);
  translate(250, 250);
  
  for(int i = 0; i < 200; i++){
    double curA = -k * sin((float)a2);
    v2 += curA * dt;
    a2 += v2 * dt;
  }
  
  for(int i = 0; i < 200; i++){
    double curA = -k * a1;
    v1 += curA * dt;
    a1 += v1 * dt;
  }
  
  fill(255);
  drawPendulum(a1);
  fill(0);
  drawPendulum(a2);
  
}