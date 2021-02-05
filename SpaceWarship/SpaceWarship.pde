int y=300;
int x=400;
void setup(){
size(800,600);
}

void draw(){
  background(0);
  fill(0,255,0);
ellipse(x,y,50,50);
if(keyPressed){
  if(key == 'w'){
    y=y-1;
    }
    else if(key == 's'){
    y=y+1;
    }
  }
  if(keyPressed){
  if(key == 'a'){
    x=x-1;
    }
    else if(key == 'd'){
    x=x+1;
    }
  }
}
