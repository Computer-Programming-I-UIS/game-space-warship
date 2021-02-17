class Ship{
  PVector pos;
  PVector vel;
  PVector acc;
  PShape s;
  float rotation;
  float heading;
  Bullet b;
  ArrayList<Bullet> bullets;
  float maxBoost;
  
  Ship(float x, float y){
    bullets = new ArrayList<Bullet>();
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    s = build();
    rotation = 0;
    heading = rotation;
    maxBoost = 1.5;
  }
  
  void update(){
    vel.add(acc);
    if(vel.mag() > maxBoost){
      vel.setMag(maxBoost);
    }
    pos.add(vel);
    if(pos.x > width+s.getWidth()){
      pos.x = 0 - s.getWidth()/2;
    }
    if(pos.y > height+s.getWidth()){
      pos.y = 0 - s.getWidth()/2;
    }
    if(pos.x < 0 - s.getWidth()){
      pos.x = width+s.getWidth()/2;
    }
    if (pos.y < 0 - s.getWidth()){
      pos.y = height+s.getHeight()/2;;
    }
    acc.mult(0);
    
    
    for(int i = bullets.size()-1; i >= 0; i--){
      b = bullets.get(i); 
      if(b.pos.x > width+s.getWidth()){
          bullets.remove(b);
          }
        else if(b.pos.y > height+s.getWidth()){
          bullets.remove(b);
          }
        else if(b.pos.x < 0 - s.getWidth()){
          bullets.remove(b);
          }
        else if (b.pos.y < 0 - s.getWidth()){
          bullets.remove(b);
          }
        }
      
      
  for(int i = bullets.size()-1; i >=0; i--){
      b = bullets.get(i);
      b.update();
      b.show();
    }
  }
  
  void show(){
    s.rotate(rotation);
    heading += rotation;
    rotation = 0;
    shape(s, pos.x, pos.y);
    stroke(255);
    
    
  } 
  
  PShape build(){
 
    PShape r = createShape();
    r.beginShape();
    r.noFill();
    r.stroke(0, 255, 0);
    r.vertex(0, -7);
    r.vertex(6, 7);
    r.vertex(-6, 7);
    r.endShape(CLOSE);
    return r;
  }
  void boost(){
    PVector dir = new PVector(sin(-heading), cos(-heading));
    dir.setMag(.5);
    acc.sub(dir);
  }
  void shoot(){
    if(bullets.size() <= 4){
      bullets.add(new Bullet(pos.x, pos.y, sin(-heading), cos(-heading)));  
    }
  }
} 
