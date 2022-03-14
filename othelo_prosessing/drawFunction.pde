void drawScore(int x, int y, int boardSize) { //<>// //<>//

  int score_black = 0; 
  int score_white = 0;
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      score_black += othello_black[i][j] ? 1 : 0;
      score_white += othello_white[i][j] ? 1 : 0;
    }

  noStroke();
  rectMode(CENTER);
  fill(#eeeeee);
  rect(x - boardSize/4, y - boardSize*0.67, boardSize*0.4, boardSize*0.2, 20);
  fill(#0d1117);
  rect(x + boardSize/4, y - boardSize*0.67, boardSize*0.4, boardSize*0.2, 20);

  fill(#0d1117);
  textAlign(CENTER);
  textSize(boardSize/10);
  fill(#0d1117);
  text(score_white, x - boardSize/4, y - boardSize * 0.63);
  fill(#eeeeee);
  text(score_black, x + boardSize/4, y - boardSize * 0.63);
}

void drawBoard(int x, int y, int boardSize) {

  float blockSize = boardSize / 8; //ブロック1辺

  /*ホバー&ボード*/
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (mouseHover_x==i && mouseHover_y==j)
        fill(#b6e9a1);
      else
        fill(#009100);
      rect(x + blockSize*-4 + blockSize*i, y + blockSize*-4 + blockSize*j, blockSize, blockSize);
    }

  /*外枠*/
  stroke(0);
  noFill();
  strokeWeight(2);
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
  if (turn)
    fill(0);
  else
    fill(255);
  ellipse(mouseX, mouseY, blockSize*0.7, blockSize*0.7);
}