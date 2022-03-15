void turnAI() { //<>//
  if (AImode==false)return;

  turn^=true;
}

void drawTurn(int x, int y, int boardSize) { //ターン表示用バー
  noStroke();
  rectMode(CENTER);
  fill(#eeeeee);
  if (!turn && mode==1)
    rect(x - boardSize/4, y - boardSize*0.533, boardSize*0.4, boardSize*0.03, 10);
  if (turn && mode==1)
    rect(x + boardSize/4, y - boardSize*0.533, boardSize*0.4, boardSize*0.03, 10);
}

boolean AImode;
boolean isHintMode;
boolean isSettingMode;

void botton(int bottonType) {
  switch(bottonType) {
  case 0: //hit button
    isHintMode^=true;
    break;
  case 1: //reset botton
    if (mode==2) {
      boardSort();
      mode++;
    } else
      boardReset();
    break;
  case 2:
    AImode^=true;
  }
}
void optionBotton(int x, int y, int boardSize) { //下部ボタン表示
  float blockSize = boardSize/3; //ブロック1辺
  float corner_x = x - boardSize*0.498;
  float corner_y = y + boardSize*0.55;
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
  for (int i=0; i<3; i++) { //マウス当たり判定
    if ((mouseX > corner_x + blockSize*i) && (corner_x + blockSize*(i+1) > mouseX) 
      && (mouseY > corner_y) && (corner_y + boardSize*0.1 > mouseY)) {
      fill(#b6e9a1);
      if (mouseClick())
        botton(i);
    } else
      fill(#51bd50);
    if (isHintMode&&i==0) //ヒントモード時ハイライト
      fill(#b6e9a1);
    if (AImode&&i==2)
      fill(#b6e9a1);
    rect(corner_x + boardSize/3*i, corner_y, boardSize/3, boardSize*0.1);
  }
  if (isHintMode) showHint();

  noFill();
  strokeWeight(1.5);
  rect(corner_x, corner_y, blockSize*3, boardSize*0.1);

  fill(255);
  textAlign(CENTER);
  textSize(boardSize/20);

  text("HINT", corner_x + blockSize/2*1, corner_y + boardSize*0.07);

  if (mode!=2)
    text("RESET", corner_x + blockSize/2*3, corner_y + boardSize*0.07);
  else
    text("SORT", corner_x + blockSize/2*3, corner_y + boardSize*0.07);

  text("AUTO", corner_x + blockSize/2*5, corner_y + boardSize*0.07);
}

void drawScore(int x, int y, int boardSize) { //スコアボード
  int score_black = getScore_black(); 
  int score_white = getScore_white();

  noStroke();
  rectMode(CENTER);
  fill(#eeeeee);
  rect(x - boardSize/4, y - boardSize*0.67, boardSize*0.4, boardSize*0.2, 10);
  fill(#0d1117);
  rect(x + boardSize/4, y - boardSize*0.67, boardSize*0.4, boardSize*0.2, 10);

  fill(#0d1117);
  textAlign(CENTER);
  textSize(boardSize/10);
  fill(#0d1117);
  text(score_white, x - boardSize/4, y - boardSize * 0.63);
  fill(#eeeeee);
  text(score_black, x + boardSize/4, y - boardSize * 0.63);
}


void drawBoard(int x, int y, int boardSize) { //ボード表示

  float blockSize = boardSize/8; //ブロック1辺

  /*ホバー&ボード*/
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (highlight[i][j])
        fill(#b6e9a1);
      else
        fill(#009100);
      rect(x + blockSize*-4 + blockSize*i, y + blockSize*-4 + blockSize*j, blockSize, blockSize);
    }

  /*外枠*/
  stroke(0);
  noFill();
  strokeWeight(1.5);
  rectMode(CENTER);
  rect(x, y, blockSize*8, blockSize*8);

  /*ドット*/
  int dotSize = boardSize / 70;
  fill(0);
  noStroke();
  ellipseMode(CENTER);
  ellipse(x + blockSize*-2, y + blockSize *-2, dotSize, dotSize);
  ellipse(x + blockSize*-2, y + blockSize * 2, dotSize, dotSize);
  ellipse(x + blockSize* 2, y + blockSize *-2, dotSize, dotSize);
  ellipse(x + blockSize* 2, y + blockSize * 2, dotSize, dotSize);

  /*駒*/
  noStroke();
  ellipseMode(CENTER);
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (othello_black[i][j])
        fill(0);
      else if (othello_white[i][j])
        fill(255);
      else
        continue;
      ellipse(x + blockSize*-4 + blockSize*0.5 + blockSize*i, y + blockSize*-4 + blockSize*0.5 + blockSize*j, blockSize*0.7, blockSize*0.7);
    }

  /*マウスに駒表示*/
}

void drawCursor(int boardSize) {
  if (mode!=1 || isSettingMode==true)return;
  int mouseGlow=abs(millis()/10%200-100)+155;
  if (turn)
    fill(0, mouseGlow);
  else
    fill(255, mouseGlow);
  ellipse(mouseX, mouseY, boardSize*0.09, boardSize*0.09);
}