void keyPressed(){
  if (keyCode == LEFT){
    ship.rotation -=.1;
  }
  if (keyCode == RIGHT){
    ship.rotation +=.1;

  }
  if (keyCode == UP){
    ship.boost();
  }
  
  if (key == ' '){
    ship.shoot();
  }
}
