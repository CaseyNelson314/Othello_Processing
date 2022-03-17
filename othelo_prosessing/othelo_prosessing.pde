/*初期ウィンドウサイズ*/ //<>//
final int WINDOW_WIDTH = 1000;
final int WINDOW_HEIGHT = 1200;

/*盤面*/
boolean othello_black[][] = new boolean[8][8];
boolean othello_white[][] = new boolean[8][8];

/*マウス位置*/
boolean highlight[][] = new boolean[8][8];

boolean turn; //true:black,false:white

int mode;

final int score_height = 100;
final int board_height = 300;
final int botton_height = 1400;

Window win = new Window();
Botton option[] = new Botton[3];
Botton board[][] = new Botton[8][8];

void setup() {
  for (int i=0; i<3; i++)option[i] = new Botton();
  for (int i=0; i<8; i++)for (int j=0; j<8; j++)board[i][j] = new Botton();
  frameRate(1000);
  win.setWindow(WINDOW_WIDTH, WINDOW_HEIGHT, 1000, 1500);
  win.margin(30);
}

void draw() {
  background(#e5b26a);
  //print((int)frameRate);
  //println("fps");

  win.drawWindow();
  switch(mode) {
  case 0: //初期化
    boardReset();
    mode++;
  case 1: //メイン処理
    mouseCD();
    optionBotton();
    drawScore();
    drawBoard();
    drawCursor();
    break;
  case 2: //ソート待機
    isHintMode=false;
    clearHighlight();
    optionBotton();
    drawScore();
    drawBoard();
  case 3:
    isHintMode=false;
    clearHighlight();
    optionBotton();
    drawScore();
    drawBoard();
  }
}
