Particle[] particles;


void setup(){
  size(1000, 600);
  particles = new Particle[100];
  for(int i = 0; i < particles.length; i++){
    if(random(1) > 0.5){
      particles[i] = new Circle();
    } else {
      particles[i] = new Rectangle();
    }
  }
}

void draw(){
  background(200);
  for(Particle p : particles){
    p.update();
  }
  
  for(Particle p : particles){
    p.show();
  }
}