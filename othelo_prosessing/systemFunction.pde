int getBoradSize() { //画面比率調整
  if (width >= height)
    return height;
  else
    return width;
}

int getScore_white() {
  int score= 0; 
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      score += othello_white[i][j] ? 1 : 0;
  return score;
}
int getScore_black() {
  int score= 0; 
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      score += othello_black[i][j] ? 1 : 0;
  return score;
}

boolean clickData, lastData;
boolean mouseClick() { 
  clickData = mousePressed && !lastData; 
  lastData = mousePressed;
  return clickData;
}

void mouseCD(int x, int y, int boardSize) { //ボードとカーソルの当たり判定をhighlightへ書き込み
  float blockSize = boardSize / 8;
  float corner_x = x + blockSize*-4;
  float corner_y = y + blockSize*-4;

  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      highlight[i][j]=false;
      if ((mouseX > corner_x + blockSize*i) && (corner_x + blockSize*(i+1) > mouseX)
        && (mouseY > corner_y + blockSize*j) && (corner_y + blockSize*(j+1) > mouseY)) {
        highlight[i][j]=true;
        if (mouseClick()&&canPut(i, j, true)) {
          turn ^= true;
          if (isSkip()) { //相手がスキップか確認
            turn ^= true;
            if (isSkip())//どっちも置けない
              mode++;
            return;
          }
          turnAI();
        }
      }
    }
}

boolean canPut(int x, int y, boolean changeMode) {
  boolean returnData = false;
  if (othello_black[x][y] || othello_white[x][y])return false; //マスに駒が存在する

  int cosTable[] = {1, 1, 0, -1, -1, -1, 0, 1};
  int sinTable[] = {0, 1, 1, 1, 0, -1, -1, -1};
  for (int i=0; i<8; i++) {
    int sum_x = cosTable[i];
    int sum_y = sinTable[i];
    if ((0>x+sum_x || x+sum_x>7)||(0>y+sum_y || y+sum_y>7)) //配列外参照時
      continue;
    if ((othello_black[x+sum_x][y+sum_y]==!turn)&&(othello_white[x+sum_x][y+sum_y]==turn)) { //1マス先 相手駒有り&&自分の駒無し
      int changeSum = 0; //反転できる個数
      for (int j=1; j<8; j++) { //2マス先以降自分駒あるか
        int index_x = x + sum_x*j;
        int index_y = y + sum_y*j;
        if ((0>index_x || index_x>7)||(0>index_y || index_y>7)) //配列外参照時
          break;
        if ((othello_black[index_x][index_y]==false)&&(othello_white[index_x][index_y]==false)) //空の場合
          break;
        if ((othello_black[index_x][index_y]==turn)&&(othello_white[index_x][index_y]==!turn)) { //自分の駒がある場合
          returnData = true;
          changeSum = j - 1;
          break;
        }
      }
      if (changeMode && returnData) //反転モード
        for (int j=0; j<=changeSum; j++) {
          int index_x = x + sum_x*j;
          int index_y = y + sum_y*j;
          othello_black[index_x][index_y]=turn;
          othello_white[index_x][index_y]=!turn;
        }
    }
  }
  return returnData;
}

void clearBoard() {
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      othello_black[i][j]=false;
      othello_white[i][j]=false;
    }
}

void clearHighlight() {
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      highlight[i][j]=false;
}

void boardReset() {
  mode=0;
  isHintMode=false;
  clearBoard();
  turn = (int)random(2)==0 ? true : false;
  if (turn) {
    othello_black[3][3]=true;
    othello_black[4][4]=true;
    othello_white[3][4]=true;
    othello_white[4][3]=true;
  } else {
    othello_white[3][3]=true;
    othello_white[4][4]=true;
    othello_black[3][4]=true;
    othello_black[4][3]=true;
  }
}

boolean isSkip() {
  int canPut = 0;
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      canPut += canPut(i, j, false) ? 1 : 0;
  println(canPut);
  return canPut==0;
}

void showHint() {
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      highlight[i][j]=canPut(i, j, false);
}

void boardSort() {
  int score_white = getScore_white();
  int score_black = getScore_black();
  clearBoard();
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (score_white==0)break;
      othello_white[i][j]=true;
      score_white--;
    }
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (score_black==0)break;
      othello_black[7-i][7-j]=true;
      score_black--;
    }
}