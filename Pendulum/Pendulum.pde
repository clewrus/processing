Ball ball;
Rope rope;

void setup(){
  size(1000, 700);
  PVector startPos = new PVector(width/3, height - 100);
  ball = new Ball(startPos.x,startPos.y , 50, 4);
  rope = new Rope(width/2, 10, startPos.x, startPos.y, 2.0);
  
}

void draw(){
  background(100);
  ball.aplyGravity();
  rope.setPos(ball.getX(), ball.getY());
  ball.aplyForce(rope.getForceVector());
  ball.makeMove();
  rope.show();
  ball.show();
}