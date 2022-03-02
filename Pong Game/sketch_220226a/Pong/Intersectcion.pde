


import java.awt.*;

public class Intersection{
  
  Rectangle ball;
  Rectangle padel;
  
  Intersection(int ballX, int ballY, int padelX, int padelY) {  
    ball= new Rectangle(ballX, ballY, 25, 25);
    padel= new Rectangle(padelX, padelY, 20, 125);
  }
  
  
  boolean intersects(){
  
    if(ball.intersects(padel)) return true;
    
    return false;
  }
}
