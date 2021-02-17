class Bullet{
  PVector pos;
  PVector vel;
  PVector prevPos;
  
  Bullet(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    prevPos = new PVector(x,y);
  }
  
  void update(){
    collision();
    vel.setMag(2);
    prevPos = pos.copy();
    pos.sub(vel);
  }
  
  void collision(){
    for(int i = 0; i < asteroids.size(); i++){
      Asteroid a = asteroids.get(i);
      for(Line l: a.lines){
        if(doIntersect(pos.x, pos.y, prevPos.x, prevPos.y, l.pos1.x+l.center.x, l.pos1.y+l.center.y, l.pos2.x+l.center.x, l.pos2.y+l.center.y)){
          ship.bullets.remove(this);
          float os = a.scale;
            Asteroid ab = new Asteroid(a.pos.x, a.pos.y, a.sides-1, os*.5);
            Asteroid ac = new Asteroid(a.pos.x, a.pos.y, a.sides-1, os*.5);
            if(ab.scale > .125){
              asteroids.add(ab);
              asteroids.add(ac);
            }
            asteroids.remove(a);
        }
      }
    }
  }
  
  void show(){
     point(pos.x, pos.y);
  }
}
