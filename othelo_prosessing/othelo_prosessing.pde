/*初期ウィンドウサイズ*/ //<>//
final int WINDOW_WIDTH = 1000;
final int WINDOW_HEIGHT = 1200;

/*盤面*/
boolean othello_black[][] = new boolean[8][8];
boolean othello_white[][] = new boolean[8][8];

/*マウス位置*/
boolean highlight[][] = new boolean[8][8];

boolean turn; //true:black,false:white


void setup() {
  frameRate(240);
  surface.setResizable(true);
  surface.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
}
int mode;
void draw() {
  background(#e5b26a);
  print((int)frameRate);
  println("fps");
  int boardSize = getBoradSize()/2;

  switch(mode) {
  case 0: //初期化
    boardReset();
    mode++;
  case 1: //メイン処理
    mouseCD(width/2, height/2, boardSize);
    optionBotton(width/2, height/2, boardSize);
    drawScore(width/2, height/2, boardSize);
    drawTurn(width/2, height/2, boardSize);
    drawBoard(width/2, height/2, boardSize);
    break;
  case 2: //ソート待機
    isHintMode=false;
    clearHighlight();
    optionBotton(width/2, height/2, boardSize);
    drawScore(width/2, height/2, boardSize);
    drawBoard(width/2, height/2, boardSize);
  case 3:
    clearHighlight();
    optionBotton(width/2, height/2, boardSize);
    drawScore(width/2, height/2, boardSize);
    drawBoard(width/2, height/2, boardSize);
  }
}