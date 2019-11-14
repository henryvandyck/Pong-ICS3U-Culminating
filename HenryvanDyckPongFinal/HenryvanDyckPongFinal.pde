// Declare needed varaibles
PFont font;
int page = 1; // page is used in the draw function to see if the user is on the home page, instructions etc...
int previousRoom = 1;
float yPosOne = 400; // Paddle One y position
float yPosTwo = 400; // Paddle Two y position
float paddleSpeed = 8;
float paddleSize = 150;
float compSpeed = 4;
// Set of booleans seeing if the player paddles should move up or down
boolean oneUp = false; 
boolean oneDown = false;
boolean twoUp = false;
boolean twoDown = false;
float ballX = 500;
float ballY = 400;
float xSpeed = 5; // x speed of the ball
float ySpeed = 5; // y speed of the ball
int playerOneScore = 0;
int playerTwoScore = 0;
int computerScore = 0;
int endScore = 11;
int gameWon = 0;

// Set screen size, modes, frame rate, font...
void setup() {
  size(1000, 800);
  noStroke();
  rectMode(CENTER);
  textAlign(CENTER);
  frameRate(100);
  font = createFont("Tw Cen MT Bold Italic", 32);
  textFont(font);
  fill(0);
  background(0);
}

// Draw different things depending on the page, call all functions that must be called 100 times a second to run.
void draw() {
  if(page == 1){
    background(0);
    // Draw changing starry background as cool effect, uses loop and randomizes
    for(int i = 0; i <= 200; i++){
    fill(255);
    ellipse(random(0,1000), random(0, 800), 4, 4);
    }
    fill(0);
    strokeWeight(20);
    ellipse(500, 300, 550, 550);
    fill(255);
    textSize(180);
    text("Pong!", 520, 350);
    button(600, 650, 150, 50, "2-Player", 3);
    button(400, 650, 150, 50, "1-Player", 2);
    button(500, 750, 200, 50, "Instructions", 4);
  }
  else if(page == 2){
    fill(255);
    background(0);
    textSize(20);
    text("Type a number below to choose the computer's difficulty \n 1 - Easy \n 2 - Intermediate \n 3 - Hard \n (default Easy)", 500, 300);
    button(400, 600, 100, 50, "Home", 1);
    // Decide difficulty of computer
    if(keyPressed){
      if(key == '1'){
        compSpeed = 4;
      }
      else if(key == '2'){
        compSpeed = 5;
      }
      else if(key == '3'){
        compSpeed = 6;
      }
    }
    button(600, 600, 150, 50, "Continue", 6);
  }
  else if(page == 3){
    fill(255);
    background(0);
    textSize(20);
    text("Player 1's controls are \n q - up \n a - down \n Player 2's controls are \n up arrow - up \n down arrow - down", 500, 300);
    button(600, 600, 150, 50, "Continue", 5);
    button(400, 600, 100, 50, "Home", 1);
  }
  else if(page == 4){
    fill(255);
    background(0);
    textSize(20);
    text("Pong was created in 1972 by Allan Alcorn for Atari. \n This version of Pong includes single-player and multi-player capabilities. \n The game works by deflecting a ball past the opposing player's paddle. \n You can increase the speed of the ball and change the direction \n by hitting the ball with the corner of your paddle. \n Turn Caps-Lock off. Press esc to exit at any time. Press p to pause at any time. \n First one to 11 wins! \n \n V1.0 Henry Curtis-Dyck 05/30/18 ", 500, 200);
    button(500, 600, 100, 50, "Home", 1);
  }
  else if(page == 5){
    // Player 1 vs. Player 2. draws background, displays scores, creates and moves paddles one and two, creates ball, constantly checks for winner, has pause ability.
    background(0);
    back();
    playerOneScoreboard();
    playerTwoScoreboard();
    paddleOne();
    paddleTwo();
    movementOne();
    movementTwo();
    ball();
    winner();
    pause();
  }
  else if(page == 6){
     // Player 1 vs. Computer. draws background, displays scores, creates and moves paddles one and computer, creates ball, constantly checks for winner, has pause ability.
    background(0);
    back();
    playerOneScoreboard();
    computerScoreboard();
    paddleOne();
    computerPaddle(compSpeed);
    movementOne();
    ball();
    winner();
    pause();
  }
  else if(page == 7){
    // Pause page, ask for 'r' to resume and 'e' to exit the game
    fill(255);
    background(0);
    textSize(20);
    text("Game Paused \n press r to resume playing and e to escape", 500, 400);
    if(keyPressed && key == 'r'){
      page = previousRoom;
    }
    if(keyPressed && key == 'e'){
      exit();
    }
  }
}

// Draws Pong background
void back(){
  stroke(255);
  strokeWeight(10);
  fill(0);
  rect(500, 400, 1060, 800);
  line(500, 0, 500, 800);
}

// Keeps individual score for p1. updates if ball reaches other side. Checks if score is the winning amount and updates
void playerOneScoreboard(){
  fill(255);
  textSize(100);
  text(playerOneScore, 250, 200);
  if(ballX >= 1000){
    playerOneScore ++;
    yPosOne = 400;
    yPosTwo = 400;
    ballX = 500;
    ballY = 400;
    xSpeed = -5;
    ySpeed = -5;
  }
  if(playerOneScore == endScore){
    gameWon = 1;
  }
}

// Keeps individual score for p2. updates if ball reaches other side. Checks if score is the winning amount and updates
void playerTwoScoreboard(){
  fill(255);
  textSize(100);
  text(playerTwoScore, 750, 200);
  if(ballX <= 0){
    playerTwoScore ++;
    yPosOne = 400;
    yPosTwo = 400;
    ballX = 500;
    ballY = 400;
    xSpeed = 5;
    ySpeed = 5;
  }
  if(playerTwoScore == endScore){
    gameWon = 2;
  }
}

// Keeps individual score for computer. updates if ball reaches other side. Checks if score is the winning amount and updates
void computerScoreboard(){
  fill(255);
  textSize(100);
  text(computerScore, 750, 200);
  if(ballX <= 0){
    computerScore ++;
    yPosOne = 400;
    yPosTwo = 400;
    ballX = 500;
    ballY = 400;
    xSpeed = 5;
    ySpeed = 5;
  }
  if(computerScore == endScore){
    gameWon = 3;
  }
}

// Checks if there is a winner and displays a message on screen. Ends game.
void winner(){
  if(gameWon != 0){
    ballX = 500;
    ballY = 400;
    xSpeed = 0;
    ySpeed = 0;
    fill(0);
    rect(500, 400, 800, 300);
    fill(255);
    textSize(80);
  }
  if(gameWon == 1){
    text("Player 1 Wins!", 500, 400);
    textSize(40);
    text("(Press r to Restart and e to Escape)", 500, 500);
    restartOrQuit();
  }
  if(gameWon == 2){
    text("Player 2 Wins!", 500, 400);
    textSize(40);
    text("(Press r to Restart and e to Escape)", 500, 500);
    restartOrQuit();
  }
  if(gameWon == 3){
    text("Computer Wins!", 500, 400);
    textSize(40);
    text("(Press r to Restart and e to Escape)", 500, 500);
    restartOrQuit();
  }
}

// Checks if user wants to restart or escape by pressing r or e
void restartOrQuit(){
  if(keyPressed && key == 'r'){
      gameWon = 0;
      ballX = 500;
      ballY = 400;
      xSpeed = 5;
      ySpeed = 5;
      playerOneScore = 0;
      playerTwoScore = 0;
      computerScore = 0;
    }
  if(keyPressed && key == 'e'){
    exit();
  }
}

// Draws paddle one. keeps it contained in screen
void paddleOne(){
  rect(20, yPosOne, 20, paddleSize);
  if(yPosOne - (paddleSize / 2) <= 0){
    yPosOne = 0 + (paddleSize / 2);
  }
  if(yPosOne + (paddleSize / 2) >= 800){
    yPosOne = 800 - (paddleSize / 2);
  }
}

// Draws paddle two. keeps it contained in screen
void paddleTwo(){
  rect(980, yPosTwo, 20, paddleSize);
  if(yPosTwo - (paddleSize / 2) <= 0){
    yPosTwo = 0 + (paddleSize / 2);
  }
  if(yPosTwo + (paddleSize / 2) >= 800){
    yPosTwo = 800 - (paddleSize / 2);
  }
}

// Checks to see if movement keys are pressed
void keyPressed() {
  if (key == 'q') {
      oneUp = true;
  }
  if (key == 'a') {
      oneDown = true;
  }
  if (keyCode == UP) {
    twoUp = true;
  }
  if (keyCode == DOWN) {
    twoDown = true;
  }
}

// If movement keys are released stops moving
void keyReleased() {
  if (key == 'q'){
    oneUp = false;
  }
  if (key == 'a'){
    oneDown = false;
  }
  if (keyCode == UP){
    twoUp = false;
  }
  if (keyCode == DOWN){
    twoDown = false;
  }
}

// moves player one
void movementOne() {
  if(oneUp == true){
    yPosOne -= paddleSpeed;
  }
  if(oneDown == true){
    yPosOne += paddleSpeed;
  }
}

// moves player two
void movementTwo(){
  if(twoUp == true){
    yPosTwo -= paddleSpeed;
  }
  if(twoDown == true){
    yPosTwo += paddleSpeed;
  }
}

// moves computer based on ball positioning. Computer AI works by following ball y position when it is in the computer's half of the screen. Returns to center when ball leaves its half.
void computerPaddle(float computerSpeed){
  fill(255);
  rect(980, yPosTwo, 20, paddleSize);
  if(ballX >= 500){
    if(yPosTwo > ballY){
      yPosTwo -= computerSpeed;
    }
    else if (yPosTwo < ballY){
      yPosTwo += computerSpeed;
    }
  }
  else if(ballX < 500){
    if(yPosTwo > 400){
      yPosTwo -= computerSpeed;
    }
    else if (yPosTwo < 400){
      yPosTwo += computerSpeed;
    }
  }
}

// Draws ball and causes it to deflect off of walls and paddles. If ball comes in contact with outer 10th of paddles increase x speed and reverse y speed.
void ball() {
  ellipse(ballX, ballY, 20, 20);
  ballX += xSpeed;
  ballY += ySpeed;
  if(ballY <= 0 || ballY >= 800){
    ySpeed *= -1;
  }
  if(ballX <= 30 && ballX >= 10 && ballY >= yPosOne - (paddleSize / 2) && ballY <= yPosOne - paddleSize / 2 + paddleSize / 10 || ballY >= yPosOne + (paddleSize / 2) - paddleSize / 10 && ballY <= yPosOne - paddleSize / 2 + paddleSize / 10 && xSpeed <0){
    xSpeed *= -1.25;
    ySpeed *= -1;
  }
  else if(ballX <= 30 && ballX >= 10 && ballY >= yPosOne - (paddleSize / 2) && ballY <= yPosOne + paddleSize / 2 && xSpeed < 0){
    xSpeed *= -1;
  }
  if(ballX <= 990 && ballX >= 970 && ballY >= yPosTwo - (paddleSize / 2) && ballY <= yPosTwo - paddleSize / 2 + paddleSize / 10 || ballY >= yPosTwo + (paddleSize / 2) - paddleSize / 10 && ballY <= yPosTwo - paddleSize / 2 + paddleSize / 10 && xSpeed > 0){
    xSpeed *= -1.25;
    ySpeed *= -1;
  }
  else if(ballX <= 990 && ballX >= 970 && ballY >= yPosTwo - (paddleSize / 2) && ballY <= yPosTwo + paddleSize / 2 && xSpeed > 0){
    xSpeed *= -1;
  }
}

// Creates buttons that lead to whatever room is chosen
void button(int x, int y, int w, int h, String text, int nextPage){
  fill(0);
  stroke(255);
  strokeWeight(5);
  rect(x, y - 10, w + 10, h);
  fill(255);
  textSize(32);
  text(text, x, y);
  if(mouseX > (x - (w / 2)) && mouseX < (x + (w / 2)) && mouseY > (y - (h/2)) && mouseY < (y + (h/2))) { 
    if(mousePressed){
      page = nextPage;
    }
  }
}

// Pauses game. Moves to paused room.
void pause(){
  previousRoom = page;
  if(keyPressed && key == 'p'){
    page = 7;
  }
}
