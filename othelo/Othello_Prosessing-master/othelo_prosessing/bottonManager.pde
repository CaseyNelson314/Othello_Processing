/*ボタンの当たり判定を作成するクラス*/

class Botton {
  private int bottonMode = CORNER;
  private float x, y, _x, _y;
  private float left_x, left_y, right_x, right_y;

  private boolean lastClick;

  void botton(float x, float y, float _x, float _y) {
    this.x = x;
    this.y = y;
    this._x = _x;
    this._y = _y;
    bottonMode(bottonMode);
  }

  void bottonMode(int mode) {
    bottonMode = mode;
    switch(mode) {
    case CORNER:
      left_x = x;
      left_y = y;
      right_x = x + _x;
      right_y = y + _y;
      break;
    case CORNERS:
      left_x = x;
      left_y = y;
      right_x = _x;
      right_y = _y;
      break;
    case CENTER:
      left_x = x - _x/2;
      left_y = y - _y/2;
      right_x = x + _x/2;
      right_y = y + _y/2;
      break;
    case RADIUS:
      left_x = x - _x;
      left_y = y - _y;
      right_x = left_x + _x*2;
      right_y = left_y + _y*2;
      break;
    }
  }

  boolean hover() {
    if (left_x <= mouseX && mouseX <=right_x && left_y <= mouseY && mouseY <=right_y)
      return true;
    return false;
  }

  boolean click() {
    if (left_x <= mouseX && mouseX <=right_x && left_y <= mouseY && mouseY <=right_y
      && mousePressed && lastClick==false) {
      lastClick = true;
      return true;
    }
    lastClick = mousePressed;
    return false;
  }

  boolean press() {
    if (left_x <= mouseX && mouseX <=right_x && left_y <= mouseY && mouseY <=right_y
      && mousePressed)
      return true;
    return false;
  }

  float x() {
    return x;
  }
  float y() {
    return y;
  }
  float _x() {
    return _x;
  }
  float _y() {
    return _y;
  }

  void drawBotton() {
    if (hover())
      fill(150);
    else
      noFill();
    rectMode(CORNERS);
    stroke(0);
    rect(left_x, left_y, right_x, right_y);
    rectMode(CORNER);

    fill(0);
    textSize(10);
    textAlign(LEFT, TOP);
    text("botton", left_x, left_y);
  }
};
