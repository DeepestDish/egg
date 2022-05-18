int ballX, ballY, myPaddleX, myPaddleY, compPaddleX, compPaddleY;
int rad = 30;
int paddleWidth = 10; int paddleHeight = 80; 

int ballSpeed, ballXDirection, ballYDirection;
int myScore, compScore;

void setup() {
  size(600, 600);
  
  ballX = width/2; ballY = height/2;
  
  myPaddleX = width - 50; // on the right
  myPaddleY = height/2;
  
  compPaddleX = 50;
  compPaddleY = height/2;
  
  ballSpeed = 2;
  ballXDirection = 1; ballYDirection = 1;
  
  myScore=0; compScore = 0;
}

void showBallPaddlesAndScores() {
fill(0, 120, 0);
stroke(0, 0, 0);
ellipseMode(CENTER);
ellipse(ballX, ballY, rad, rad);

rectMode(CENTER);
fill(175, 0, 0);
rect(myPaddleX, myPaddleY, paddleWidth, paddleHeight);
rect(compPaddleX, compPaddleY, paddleWidth, paddleHeight);

fill(0, 0, 0);
textSize(14);
textAlign(LEFT, TOP);
text("Computer Score: " + compScore, compPaddleX, 40);
textAlign(RIGHT, TOP);
text("My Score: " + myScore, myPaddleX, 40);
}


Boolean doScoringLogic() {
  if (myScore < 10 && compScore < 10) {
return false; 
  }

  textSize(36);
if (myScore >= 10 && compScore < 10) {
text("YOU WIN!", width/2, height/2); 
} else if (compScore >= 10 && myScore < 10) {
text("COMPUTER WINS!", width/2, height/2); 
} else if (compScore == 10 && myScore == 10) {
text("TIE!", width/2, height/2); 
}
return true; 
}

void moveMyPaddle() {
  if (key == 'w' && keyPressed && (myPaddleY - paddleHeight/2) > 0) {
  myPaddleY -= 4;
  } else if (key == 's' && keyPressed && (myPaddleY + paddleHeight/2) < height) {
  myPaddleY += 4;
  }
}
void moveCompPaddle() {
// Challenge problem: Could you design a better algorithm?
// This is technically ~AI~
if (ballY > compPaddleY) {
    compPaddleY += 4;
    } else if (ballY < compPaddleY) {
    compPaddleY -= 4;
    }
}

void handleCollisions() {
  int myPaddleTop = myPaddleY - paddleHeight/2 ; 
  int myPaddleBottom = myPaddleY + paddleHeight/2 ; 

  int compPaddleTop = compPaddleY - paddleHeight/2 ; 
  int compPaddleBottom = compPaddleY + paddleHeight/2 ; 

  Boolean hitMyPaddle = ((ballX + rad/2) > myPaddleX) && (ballY > myPaddleTop) && (ballY < myPaddleBottom);
  Boolean hitCompPaddle = ((ballX - rad/2) < compPaddleX) && (ballY > compPaddleTop) && (ballY < compPaddleBottom);

  if (hitMyPaddle || hitCompPaddle) {
     ballXDirection *= -1;
  }

  if (((ballY - rad/2) < 0) || ((ballY + rad/2) > height)) {
     ballYDirection *= -1;
  }

}


void handlePointScoring() {
// If it gets past paddle, increase score and place ball in center.
if ((ballX + rad/2) > width) {
    ballX = width/2; ballY = height/2; ballSpeed = 0;
compScore++;
    } else if ((ballX - rad/2) < 0) {
ballX = width/2; ballY = height/2; ballSpeed = 0;
myScore++;
    }

  // Resume play
if (key == ' ' && keyPressed) {
  ballSpeed = 2;
  if (compScore + myScore > 4) {
    ballSpeed += ((compScore + myScore) / 2);
  }
  }
}


void moveBall() {
  ballX += ballSpeed * ballXDirection;
  ballY += ballSpeed * ballYDirection;
}

void draw() {
  frameRate(30);
  background(127, 127, 127);
  showBallPaddlesAndScores();

  Boolean isGameOver = doScoringLogic(); 
  if (!isGameOver) {
    moveMyPaddle();
    moveCompPaddle();
  
    handleCollisions();
    handlePointScoring();
    
    moveBall(); 
  }
}
