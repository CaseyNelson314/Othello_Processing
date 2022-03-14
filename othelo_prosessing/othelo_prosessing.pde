/*初期ウィンドウサイズ*/ //<>//
final int WINDOW_WIDTH = 1000;
final int WINDOW_HEIGHT = 1200;

/*盤面*/
boolean othello_black[][] = new boolean[8][8];
boolean othello_white[][] = new boolean[8][8];

/*マウス位置*/
int mouseHover_x, mouseHover_y;

boolean turn; //true:black,false:white


void setup() {
  frameRate(240);
  surface.setResizable(true);
  surface.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
}
int mode;
void draw() {
  background(#e5b26a);
  //print((int)frameRate);
  //println("fps");
  switch(mode) {
  case 0: //初期化
    boardReset();
    mode++;
  case 1: //メイン処理
    mouseCD(width/2, height/2, getBoradSize()/2);
    drawScore(width/2, height/2, getBoradSize()/2);
    drawBoard(width/2, height/2, getBoradSize()/2);
    break;
  case 2: //終了処理
    drawScore(width/2, height/2, getBoradSize()/2);
    drawBoard(width/2, height/2, getBoradSize()/2);
    mouseHover_x=-1;
    mouseHover_y=-1;
  }
}