/*
 *可変ウィンドウ時、座標を使えるように変換するクラス
 *仮想ウィンドウは中央揃え
 */

class Window {
  private float margin;
  private int vWindow_x, vWindow_y; //仮想ウィンドウサイズ
  private float left_x, left_y, right_x, right_y; //仮想ウィンドウ座標

  private float widthPerHeight, heightPerWidth; //縦横比

  //初期画面Xピクセル,初期画面Yピクセル,仮想画面Xピクセル,仮想画面Yピクセル
  void setWindow(int pixel_x, int pixel_y, int vPixel_x, int vPixel_y) {
    surface.setResizable(true);
    surface.setSize(pixel_x, pixel_y);
    widthPerHeight = (float)vPixel_x / vPixel_y;
    heightPerWidth = (float)vPixel_y / vPixel_x;
    vWindow_x = vPixel_x;
    vWindow_y = vPixel_y;
  }

  //余白率(％)
  void margin(float margin) {
    this.margin = 1 - margin/100;
  }


  //仮想ウィンドウでの座標 > 実ウィンドウでの座標
  float x(float point_x) {
    updatePoint_x();
    float vWindowSize = right_x - left_x;
    return left_x + vWindowSize*point_x/vWindow_x;
  }
  float y(float point_y) {
    updatePoint_y();
    float vWindowSize = right_y - left_y;
    return left_y + vWindowSize*point_y/vWindow_y;
  }


  //実ウィンドウでの座標 > 仮想ウィンドウでの座標
  float vx(float point_x) {
    updatePoint_x();
    return (point_x-left_x)*vWindow_x/getWidth();
  }
  float vy(float point_y) {
    updatePoint_y();
    return (point_y-left_y)*vWindow_y/getHeight();
  }


  //仮想ウィンドウでのサイズ > 実ウィンドウでのサイズ
  float width(float _width) {
    updatePoint_x();
    return getWidth() * _width / vWindow_x;
  }
  float height(float _height) {
    updatePoint_y();
    return getHeight() * _height / vWindow_y;
  }


  //仮想ウィンドウサイズ取得(実ウィンドウサイズ)
  float getWidth() {
    updatePoint_x();
    return right_x - left_x;
  }
  float getHeight() {
    updatePoint_y();
    return right_y - left_y;
  }


  void drawWindow() {
    updatePoint_x();
    updatePoint_y();
    fill(200);
    noStroke();
    rectMode(CORNERS);
    rect(left_x, left_y, right_x, right_y);
    rectMode(CORNER);
    fill(0);
    textSize(10);
    textAlign(LEFT, TOP);
    text("virtual window ("+vWindow_x+"×"+vWindow_y+") "+int(margin*100)+"%", left_x, left_y);
    textAlign(LEFT, DOWN);
  }

  private float lastSize; //前回の幅高さ合計値
  boolean sizeUpdate() {
    boolean isUpdate = false;
    if (width+height != lastSize)isUpdate = true;
    lastSize = width+height;
    return isUpdate;
  }


  private void updatePoint_x() {
    if (width * heightPerWidth >= height) { //横幅オーバー
      left_x = (width-height*widthPerHeight*margin)/2;
      right_x = (width+height*widthPerHeight*margin)/2;
    } else { //縦幅オーバー
      left_x = width*(1-margin)/2;
      right_x = width*(1+margin)/2;
    }
  }
  private void updatePoint_y() {
    if (width * heightPerWidth >= height) { //横幅オーバー
      left_y = height*(1-margin)/2;
      right_y = height*(1+margin)/2;
    } else { //縦幅オーバー
      left_y = (height-width*heightPerWidth*margin)/2;
      right_y = (height+width*heightPerWidth*margin)/2;
    }
  }
};
