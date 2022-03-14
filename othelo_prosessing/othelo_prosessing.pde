/*初期ウィンドウサイズ*/
final int WINDOW_WIDTH = 1000;
final int WINDOW_HEIGHT = 1200;

/*盤面*/
boolean othello_black[][] = new boolean[8][8];
boolean othello_white[][] = new boolean[8][8];

/*マウス位置*/
int mouseHover_x, mouseHover_y;

int mouseClick_x, mouseClick_y;

boolean turn;

void setup() {
  frameRate(10000);
  surface.setResizable(true);
  surface.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void draw() {
  background(#e5b26a);
  print((int)frameRate);
  println("fps");
  boardReset();
  mouseCD(width/2, height/2, getBoradSize()/2);
  drawBoard(width/2, height/2, getBoradSize()/2);
}

boolean canPut(int x, int y) {
  if (othello_black[x][y] || othello_white[x][y])return false;
  int tarnTable_x[]={1, 1, 0, -1, -1, -1, 0, 1};
  int tarnTable_y[]={0, 1, 1, 1, 0, -1, -1, -1};
  for (int i=0; i<8; i++) {

    int sum_x=tarnTable_x[i];
    int sum_y=tarnTable_y[i];
    if ((0<=x+sum_x && x+sum_x<=7)&&(0<=y+sum_y && y+sum_y<=7)&&
      (othello_black[x+sum_x][y+sum_y]==!turn)&&(othello_black[x+sum_x][y+sum_y]==!turn)) {//1マス先に相手駒
      
      int index=1;
      while (othello_black[x+sum_x*index][y+sum_y*index]==turn &&
        othello_black[x+sum_x*index][y+sum_y*index]==turn) {//2マス先以降自分駒あるか

        index++;
      }
    }
  }
  return true;
}