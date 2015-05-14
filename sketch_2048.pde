
final int fieldSize = 4;
final int startPos = 10;
final int cellSize = 100;
final int minDist = 20;

final int UP = 1;
final int DOWN = 2;
final int LEFT = 3;
final int RIGHT = 4;

int isGameOver=0;
int checkGameOver[] = new int[5];

int field[][] = new int[fieldSize][fieldSize];
color clist[] = new color[13];
int cell[] = new int[2];

float startx, starty, endx, endy;

void setup() {
  println("program starts");
  size(450, 450);
  background(#FFF6B4);
  textSize(80);
  noStroke();


  clist[0] = color(#FF5555);
  clist[1] = color(#FF4444);
  clist[2] = color(#FF7777);
  clist[3] = color(#EE8855);
  clist[4] = color(#FF0044);
  clist[5] = color(#FFAABB);
  clist[6] = color(#FFBBAA);

  cell = genCell();
  field[cell[0]][cell[1]] = 2;

  cell = genCell();
  field[cell[0]][cell[1]] = 2;

  println("setup end");
}

void draw() {
  background(#FFF6B4);
  for (int i=0;i<fieldSize;i++) {
    for (int j=0;j<fieldSize;j++) {
      if (field[i][j]>0) {
        fill(clist[chCList(field[i][j])]);
        rect(startPos+i*cellSize+10*i, startPos+j*cellSize+10*j, cellSize, cellSize);
        fill(#FFFFFF);
        text(field[i][j], startPos+i*cellSize+10*i+10, startPos+j*cellSize+10*j+80);
      }
    }
  }

  if (isGameOver==1) {
    noLoop();
    println("game over");
  }
}


void mousePressed() {
  startx = mouseX;
  starty = mouseY;
}


void mouseReleased() {

  endx = mouseX;
  endy = mouseY;

  int direction=0;

  //detect flicked direction
  float dist = sqrt(pow(endx-startx, 2)+pow(endy-starty, 2));

  if (dist>minDist) {
    
    
    //check game over
    int isSpace=0,forigner=0;
    for (int i=0;i<4;i++) {
      if (field[0][i]==0 || field[1][i]==0 || field[2][i]==0 || field[3][i]==0) {
        isSpace = 1;
      }
      
      if(field[i][0]==field[i][1] || field[i][1]==field[i][2] || field[i][2]==field[i][3]){
        forigner = 1;
      }
      
      if(field[0][i]==field[1][i] || field[1][i]==field[2][i] || field[2][i]==field[3][i]){
        forigner = 1;
      }
    }
    
    if(forigner+isSpace==0){
      isGameOver = 1;
    }
    
    
    if (abs(startx-endx)>abs(starty-endy)) {
      if (endx-startx>0) {
        direction = RIGHT;
      }
      else {
        direction = LEFT;
      }
    }
    else {
      if (endy-starty>0) {
        direction = DOWN;
      }
      else {
        direction = UP;
      }
    }


    //move cells
    int beginx=0, beginy=0, finx=4, finy=4; 
    int slidex=0, slidey=0, isMoved=0, t, markMap[] = new int[4];

    if (direction==LEFT) {
      for (int i=0;i<4;i++) {
        for (int j=1;j<4;j++) {
          if (field[j][i]>0) {
            t=j+1;
            while (t!=1) {
              --t;
              if (field[t][i]==field[t-1][i] && markMap[t-1]==0) {
                markMap[t-1] = 1;
                field[t-1][i] *= 2;
                field[t][i] = 0;
                isMoved = 1;
                break;
              }else if(field[t-1][i]==0){              
                field[t-1][i] = field[t][i];
                field[t][i] = 0;
                isMoved = 1;
              }
              
            }
          }
        }
        for(int k=0;k<4;k++)markMap[k] = 0;
      }
      
    }else if (direction==RIGHT) {

      for (int i=0;i<4;i++) {
        for (int j=2;j>=0;j--) {
          if (field[j][i]>0) {
            t=j-1;
            while (t!=2) {
              ++t;
              if (field[t][i]==field[t+1][i] && markMap[t+1]==0) {
                markMap[t+1] = 1;
                field[t+1][i] *= 2;
                field[t][i] = 0;
                isMoved = 1;
                break;
              }else if(field[t+1][i]==0){
                field[t+1][i] = field[t][i];
                field[t][i] = 0;
                isMoved = 1;
              }else{
                if(checkGameOver[0]==1){
                  checkGameOver[2] = 1;
                }
              }

            }
          }
        }
        for(int k=0;k<4;k++)markMap[k] = 0;
      }
    }
    else if (direction==UP) {
      for (int i=0;i<4;i++) {
        for (int j=1;j<4;j++) {
          if (field[i][j]>0) {
            t=j+1;
            while (t!=1) {
              --t;
              if (field[i][t]==field[i][t-1] && markMap[t-1]==0) {
                markMap[t-1] = 1;
                field[i][t-1] *= 2;
                field[i][t] = 0;
                isMoved = 1;
                break;
              }else if(field[i][t-1]==0){              
                field[i][t-1] = field[i][t];
                field[i][t] = 0;
                isMoved = 1;
              }

            }
          }
        }
        for(int k=0;k<4;k++)markMap[k] = 0;
      }
    }
    else if (direction==DOWN) {
      for (int i=0;i<4;i++) {
        for (int j=3;j>=0;j--) {
          if (field[i][j]>0) {
            t=j-1;
            while (t!=2) {
              ++t;
              if (field[i][t]==field[i][t+1] && markMap[t+1]==0) {
                markMap[t+1] = 1;
                field[i][t+1] *= 2;
                field[i][t] = 0;
                isMoved = 1;
                break;
              }else if(field[i][t+1]==0){              
                field[i][t+1] = field[i][t];
                field[i][t] = 0;
                isMoved = 1;
              }
              
            }
          }
        }
        for(int k=0;k<4;k++)markMap[k] = 0;
      }
    }



    //generate new cell
    while (isMoved==1) {
      println("direction:" + direction);

      cell = genCell();

      if (field[cell[0]][cell[1]]==0) {
        field[cell[0]][cell[1]] = 2;
        break;
      }

    }

  }
}


int chCList(int n) {

  //durty, but fast
  if (n==2)return 1;
  if (n==4)return 2;
  if (n==8)return 3;
  if (n==16)return 4;
  if (n==32)return 5;
  if (n==64)return 6;
  if (n==128)return 7;
  if (n==256)return 8;
  if (n==512)return 9;
  if (n==1024)return 10;
  if (n==2048)return 11;
  if (n==4096)return 12;
  if (n==8192)return 13;
  return 0;
}

int[] genCell() {
  int t[] = new int[2];
  t[0] = (int)random(3.999);
  t[1] = (int)random(3.999);

  return t;
}

