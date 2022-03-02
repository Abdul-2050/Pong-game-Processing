

// for padel
int rightPadelY, leftPadelY;

// for ball
int ballX, ballY;
int ballXDir, ballYDir;

// play
boolean play;

// intersectiswon
Intersection inter1;
Intersection inter2;

// score
int leftP = 0;
int  rightP= 0;

// test
boolean up, down;
boolean w, s;

void setup() {
  // frame size
  size(800, 600);
  surface.setTitle("Pong Game");

  rightPadelY=  475/2;
  leftPadelY=  475/2;

  ballX= width/2-50;
  ballY= height/2-100;

  ballXDir = 12;
  ballYDir= 4;

  play= false;
}

void draw() {
  background(52, 73, 94);
  // lines
  for (int a=0; a<= 600; a+=30) {
    fill(52, 152, 219);
    rect(width/2, a, 20, 20);
  }

  movePadel();

  // right padel
  fill(230, 126, 34);
  rect(30, leftPadelY, 20, 125);
  // intersection with Borders
  if (rightPadelY<=0)  rightPadelY=0;
  if (rightPadelY >=475) rightPadelY= 475;
  // right padel
  rect(750, rightPadelY, 20, 125);
  if (leftPadelY<=0) leftPadelY=0;
  if (leftPadelY >=475) leftPadelY= 475;

  // ball
  ellipse(ballX, ballY, 25, 25);
  if (play) {
    ballX += ballXDir;
    ballY += ballYDir;


    if (ballX <=0) {
      ballXDir = -ballXDir;
      rightP++;
    }

    if (ballY <=0 ) {
      ballYDir = -ballYDir;
    }

    if (ballX >=789) {
      ballXDir = -ballXDir;
      leftP++;
    }

    if (ballY >=589 ) {
      ballYDir = -ballYDir;
    }
  }

  // intersection
  inter1 = new Intersection(ballX, ballY, 765, rightPadelY);
  inter2 = new Intersection(ballX, ballY, 45, leftPadelY);

  if (inter1.intersects()) {
    ballXDir = -ballXDir;
  }

  if (inter2.intersects()) {
    ballXDir = -ballXDir;
  }

  // score
  textSize(50);
  stroke(0);
  fill(46, 204, 113);
  text("" + leftP, 200, 50);
  text("" + rightP, 600, 50);

  // win state
  if (leftP >= 10) {
    play= false;
    textSize(50);
    stroke(0);
    fill(231, 76, 60);
    text("Left Player Won", 250, height/2);
    ballX= width/2-50;
    ballY= height/2-100;
    textSize(25);
    text("Enter R to Restart", 350, 370);
  }

  if (rightP >= 10) {
    play= false;
    textSize(50);
    stroke(0);
    fill(231, 76, 60);
    text("Right Player Won", 250, height/2);
    ballX= width/2-50;
    ballY= height/2-100;
    textSize(25);
    text("Enter R to Restart", 350, 370);
  }
}


int steps=12;

void movePadel() {

  // controls
  if (up) {
    rightPadelY= rightPadelY -steps;
  }

  if (down) {
    rightPadelY= rightPadelY +steps;
  }

  if ( s) {
    leftPadelY = leftPadelY+steps;
  }

  if ( w) {
    leftPadelY = leftPadelY -steps;
  }


  // start game
  if (keyPressed && key == ENTER ) play= true;

  // restart
  if (key == 'r' || key == 'R') {
    leftP=0;
    rightP= 0;
   // ballXDir = 10;
    //ballYDir= 4;

    play= true;
  }
}

void keyPressed() {
  up = keyCode == UP ? true : up;
  down = keyCode == DOWN ? true : down;

  s = key == 's' ? true : s;
  w = key == 'w' ? true : w;
}

void keyReleased() {
  up = keyCode == UP ? false : up;
  down = keyCode == DOWN ? false : down;

  s = key == 's' ? false : s;
  w = key == 'w' ? false : w;
}
