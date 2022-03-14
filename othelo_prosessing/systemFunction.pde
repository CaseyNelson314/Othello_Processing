int getBoradSize() { //画面比率調整
  if (width >= height)
    return height;
  else
    return width;
}

boolean clickData, lastData;
void mouseCD(int x, int y, int boardSize) { //ボードとカーソルの当たり判定をmouseHoverへ書き込み
  float blockSize = boardSize / 8;
  float corner_x = x + blockSize*-4;
  float corner_y = y + blockSize*-4;

  mouseHover_x = mouseHover_y = -1;
  mouseClick_x = mouseClick_y = -1;

  clickData = mousePressed && !lastData; 
  lastData=mousePressed;

  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if ((mouseX > corner_x + blockSize*i) && (corner_x + blockSize*(i+1) > mouseX) && (mouseY > corner_y + blockSize*j) && (corner_y + blockSize*(j+1) > mouseY)) {
        mouseHover_x = i;
        mouseHover_y = j;
        if (clickData && canPut(i, j)) {
          mouseClick_x=i;
          mouseClick_y=j;
        }
      }
    }
}

void boardReset() {
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      othello_black[i][j]=false;
      othello_white[i][j]=false;
    }
  othello_black[3][3]=true;
  othello_black[4][4]=true;
  othello_white[3][4]=true;
  othello_white[4][3]=true;
}