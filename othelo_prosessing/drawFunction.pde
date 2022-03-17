boolean AImode; //<>//
boolean isHintMode;

void drawScore() { //スコアボード
  final int score_height = 100;
  noStroke();
  rectMode(CENTER);
  int glow=abs(millis()/5%200-100)+120;
  fill(glow);
  if (!turn && mode==1)
    rect(win.x(250), win.y(score_height), win.width(440), win.height(220), 20);
  if (turn && mode==1)
    rect(win.x(750), win.y(score_height), win.width(440), win.height(220), 20);
    
  noStroke();
  rectMode(CENTER);
  fill(#eeeeee);
  rect(win.x(250), win.y(score_height), win.width(400), win.height(180), 10);
  fill(#0d1117);
  rect(win.x(750), win.y(score_height), win.width(400), win.height(180), 10);

  fill(#0d1117);
  textAlign(CENTER, CENTER);
  textSize(win.width(80));
  fill(#0d1117);
  text(getScore_white(), win.x(250), win.y(score_height-10));
  fill(#eeeeee);
  text(getScore_black(), win.x(750), win.y(score_height-10));
}

void drawBoard() { //ボード表示
  /*ホバー&ボード*/
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      fill(#009100);
      if (highlight[i][j])
        fill(#b6e9a1);
      else
        fill(#009100);
      rect(win.x(i*125), win.y(board_height+j*125), win.width(125), win.height(125));
    }

  /*外枠*/
  stroke(0);
  noFill();
  strokeWeight(1.5);
  rectMode(CORNER);
  rect(win.x(0), win.y(board_height), win.width(1000), win.height(1000));

  /*ドット*/
  fill(0);
  noStroke();
  ellipseMode(CENTER);
  ellipse(win.x(250), win.y(board_height+250), win.width(10), win.width(10));
  ellipse(win.x(250), win.y(board_height+750), win.width(10), win.width(10));
  ellipse(win.x(750), win.y(board_height+250), win.width(10), win.width(10));
  ellipse(win.x(750), win.y(board_height+750), win.width(10), win.width(10));

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
      ellipse(win.x(63+i*125), win.y(board_height+63+j*125), win.width(80), win.width(80));
    }

  /*マウスに駒表示*/
}


void optionBotton() {

  option[0].botton(win.x(0), win.y(botton_height), win.width(333), win.height(100));
  option[1].botton(win.x(333), win.y(botton_height), win.width(333), win.height(100));
  option[2].botton(win.x(666), win.y(botton_height), win.width(333), win.height(100));

  stroke(0);
  strokeWeight(1);
  //HINT
  fill(#51bd50);
  rectMode(CORNER);
  isHintMode^=option[0].click();
  if (option[0].hover()||isHintMode)fill(#b6e9a1);
  rect(win.x(0), win.y(botton_height), win.width(333), win.height(100));
  if (isHintMode)showHint();
  //RESET,SORT
  fill(#51bd50);
  if (option[1].click()) {
    AImode = false;
    isHintMode = false;
    if (mode==2) {
      boardSort();
      mode++;
    } else
      boardReset();
  }
  if (option[1].hover())fill(#b6e9a1);
  rect(win.x(333), win.y(botton_height), win.width(333), win.height(100));
  //AUTO
  fill(#51bd50);
  AImode^=option[2].click();
  if (option[2].hover()||AImode)fill(#b6e9a1);
  if (isHintMode) showHint();  
  rect(win.x(666), win.y(botton_height), win.width(333), win.height(100));
  //ボタン枠
  noFill();
  strokeWeight(1.5);
  rect(win.x(0), win.y(botton_height), win.width(1000), win.height(100));
  //文字
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(win.width(60));
  text("HINT", win.x(167), win.y(botton_height+40));
  if (mode!=2)
    text("RESET", win.x(500), win.y(botton_height+40));
  else
    text("SORT", win.x(500), win.y(botton_height+40));
  text("AUTO", win.x(833), win.y(botton_height+40));
}


void drawCursor() {
  if (mode!=1)return;
  int mouseGlow=abs(millis()/10%200-100)+155;
  if (turn)
    fill(0, mouseGlow);
  else
    fill(255, mouseGlow);
  ellipse(mouseX, mouseY, win.width(80), win.width(80));
}


void turnAI() { //<>//
  if (AImode==false)return;

  turn^=true;
}
