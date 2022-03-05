

// for padel
int rightPadelY, leftPadelY;

// for ball
int ballX, ballY;
int ballXDir, ballYDir;

// play
boolean play;
// start
boolean start;

// intersectiswon
Intersection inter1;
Intersection inter2;

// score
int leftP = 0;
int  rightP= 0;

// test
boolean up, down;
boolean w, s;

//  text size
int winText = 50;
int restartText = 25;

int scoreText= 50;


// KI
KI ai;
boolean auto= false;

void setup() {
  // frame size
  size(800, 500);
  surface.setTitle("Pong Game");
  surface.setResizable(true);

  //rightPadelY=  475/2;
  //leftPadelY=  475/2;

  rightPadelY= (height-125 ) /2;
  leftPadelY= (height-125) / 2;


  ballX= width/2-50;
  ballY= height/2-100;

  ballXDir = 15;
  ballYDir= 4;


  play= false;
  start= false;
}

void draw() {
  // background
  background(52, 73, 94);
  // lines
  for (int a=0; a<= height; a+=30) {
    fill(52, 152, 219);
    rect(width/2, a, 20, 20);
  }

  // move padel
  movePadel();
  // intersection
  intersection();

  // right padel
  fill(230, 126, 34);
  rect(30, leftPadelY, 20, 125, 20);
  // left Padel
  rect(width -50, rightPadelY, 20, 125, 20);

  // ball
  ellipse(ballX, ballY, 25, 25);

  // score
  textSize(scoreText);
  stroke(0);
  fill(46, 204, 113);
  text("" + leftP, width/2/2, 50);
  text("" + rightP, width/2+ width/2/2, 50);

  // win state
  winState();

  increaseSpeed() ;
  // padel resmosive
  if (start == false) {
    rightPadelY= (height-125 ) /2;
    leftPadelY= (height-125) / 2;
    textAlign(CENTER);
    textSize(restartText);
    fill(0, 255, 0);
    ballY= height / 2;
    ballX = width/ 2;
    text("Enter R to Restart", width/2, height/2+50);
  }

  // width checking
  discreaseTextSize();
}

void winState() {
  // winstate
  if (leftP >= 10) {
    play= false;
    textSize(winText);
    stroke(0);
    fill(231, 76, 60);
    textAlign(CENTER, CENTER);
    text("Left Player Won", width/2, height/2);
    ballX= width/2-50;
    ballY= height/2-100;
    start = false;
  }

  if (rightP >= 10) {
    play= false;
    textSize(winText);
    stroke(0);
    fill(231, 76, 60);
    textAlign(CENTER, CENTER);
    text("Right Player Won", width/2, height/2);
    ballX= width/2-50;
    ballY= height/2-100;
    start = false;
  }

  ai = new KI(ballX, ballY, ballXDir, ballYDir);
  if (auto) {
    leftPadelY =  ai.movePadel();
  }
  AIOnOff();
}

void AIOnOff() {
  if(keyPressed & key == 'a' || key == 'A'){
    auto = true;
  }
  
  if(keyPressed & key == 'm' || key == 'M'){
    auto = false;
  }
}


int steps=12;

void intersection() {

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

    if (ballX >=width-25) {
      ballXDir = -ballXDir;
      leftP++;
    }

    if (ballY >=height-25 ) {
      ballYDir = -ballYDir;
    }
  }

  // intersection with padel
  inter1 = new Intersection(ballX, ballY, width-50, rightPadelY);
  inter2 = new Intersection(ballX, ballY, 45, leftPadelY);

  if (inter1.intersects()) {
    ballXDir = -ballXDir;
  }
  if (inter2.intersects()) {
    ballXDir = -ballXDir;
  }

  // intersection with Borders
  if (rightPadelY<=0)  rightPadelY=0;
  if (rightPadelY >=height -125) rightPadelY= height-125;
  // right padel
  if (leftPadelY<=0) leftPadelY=0;
  if (leftPadelY >=height -125) leftPadelY= height-125;
}

void movePadel() {

  // controls
  if (up) {
    rightPadelY= rightPadelY -steps;
  }

  if (down) {
    rightPadelY= rightPadelY +steps;
  }

  if (s) {
    leftPadelY = leftPadelY+steps;
  }

  if (w) {
    leftPadelY = leftPadelY -steps;
  }


  // start game
  if (keyPressed && key == ENTER ) {
    play= true;
    start= true;
  }

  // restart
  if (key == 'r' || key == 'R') {
    leftP=0;
    rightP= 0;
    // ballXDir = 10;
    //ballYDir= 4;

    play= true;
    start= true;
  }
}

void increaseSpeed() {
  // under Construcktion
}

void discreaseTextSize() {
  if ( width <= 460) {
    winText = 20;
    restartText = 14;
    println("test");
  } else {
    winText = 50;
    restartText = 25;
  }

  if (width <= 400) {
    scoreText= 30;
  } else {
    scoreText = 50;
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
