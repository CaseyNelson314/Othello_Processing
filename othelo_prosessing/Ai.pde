int situation;

void turnAI() {
  boolean aiTurn = turn;
  int scoreMap[][] ={
    {0, 1, 1, 0}, 
    {1, 0, 0, 1}, 
    {1, 0, 0, 1}, 
    {0, 1, 1, 0}, 
  };


  int canPutCount=0;
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
      if (canPut(i, j, false))canPutCount++;
  canPutCount=(int)random(canPutCount)+1;
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      if (canPut(i, j, false))canPutCount--;
      if (canPutCount==0) {
        canPut(i, j, true);
        break;
      }
    }
  //println(canPutCount);
  turn^=true;


  //switch(situation) {
  //case 0: //序盤(4×4内)
  //  int canPutCount=0;
  //  for (int i=0; i<4; i++)
  //    for (int j=0; j<4; j++)
  //      if (canPut(i+2, j+2, false))canPutCount++;

  //  int maxScorePointCount=0;
  //  for (int i=0; i<4; i++)
  //    for (int j=0; j<4; j++)
  //      if (canPut(i+2, j+2, false) && scoreMap[i][j]==1)maxScorePointCount++;

  //  maxScorePointCount=(int)random(maxScorePointCount);
  //  for (int i=0; i<4; i++)
  //    for (int j=0; j<4; j++) {
  //      if (canPut(i+2, j+2, false))maxScorePointCount--;
  //      if (maxScorePointCount==0)canPut(i+2, j+2, true);
  //    }
  //  println(canPutCount);

  //  if (canPutCount==0)situation++; //序盤終了
  //  else break;

  //case 1: //中盤
  //}

  //turn^=true;
}
