/*初期ウィンドウサイズ*/ //<>//
final int WINDOW_WIDTH = 1000;
final int WINDOW_HEIGHT = 1200;

/*盤面*/
boolean othello_black[][] = new boolean[8][8];
boolean othello_white[][] = new boolean[8][8];

/*マウス位置*/
int mouseHover_x, mouseHover_y;

int mouseClick_x, mouseClick_y;

boolean turn=true; //true:black,false:white

void setup() {
  frameRate(10000);
  surface.setResizable(true);
  surface.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
  println("turn : white  ");
}

void draw() {
  background(#e5b26a);
  //print((int)frameRate);
  //println("fps");
  boardReset();
  mouseCD(width/2, height/2, getBoradSize()/2);
  drawBoard(width/2, height/2, getBoradSize()/2);
}

boolean canPut(int x, int y) {
  if (othello_black[x][y] || othello_white[x][y])return false; //マスに駒が存在する

  int cosTable[]={1, 1, 0, -1, -1, -1, 0, 1};
  int sinTable[]={0, 1, 1, 1, 0, -1, -1, -1};

  for (int i=0; i<8; i++) {

    int sum_x=cosTable[i];
    int sum_y=sinTable[i];

    if ((0>x+sum_x || x+sum_x>7)||(0>y+sum_y || y+sum_y>7))//配列外参照時
      continue;

    if ((othello_black[x+sum_x][y+sum_y]==!turn)&&(othello_white[x+sum_x][y+sum_y]==turn)) { //1マス先 相手駒有り&&自分の駒無し
      for (int j=1; j<7; j++) { //2マス先以降自分駒あるか
        int index_x=x+sum_x*j;
        int index_y=y+sum_y*j;

        if ((0>index_x || index_x>7)||(0>index_y || index_y>7))//配列外参照時
          break;
        if ((othello_black[index_x][index_y]==false)&&(othello_white[index_x][index_y]==false))//空の場合
          break;
        if ((othello_black[index_x][index_y]==turn)&&(othello_white[index_x][index_y]==!turn))//自分の駒がある場合:反転可
          return true;
      }
    }
  }
  return false;
}