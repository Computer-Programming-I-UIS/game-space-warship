class Asteroid{
  PVector pos;
  PVector vel;
  PShape s;
  
  float scale;
  int sides;
  
  ArrayList<Line> lines;
  
  Asteroid(float x, float y, int _sides, float _scale){
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1,1));
    lines = new ArrayList<Line>();
    scale = _scale;
    sides = _sides;
    build();    
  }
  
  Asteroid(float x, float y, int _sides){
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1,1));
    lines = new ArrayList<Line>();
    scale = 1;
    sides = _sides;
    build();    
  }
  
  
  void update(){
    pos.add(vel);
    for(Line l: lines){
      l.update(pos);
    }
    
    if(pos.x > width){
      pos.x = 0;
    }
    if(pos.y > height){
      pos.y = 0;
    }
    if(pos.x < 0){
      pos.x = width;
    }
    if (pos.y < 0){
      pos.y = height;
    }
  }
  
  void show(){
    for(Line l: lines){
      l.show();
    }
  }  
    
  void build(){
    Line l;
    float x1;
    float x2 = 0;
    float y1;
    float y2 = 0;
    x1 = cos(0 * 0.1 * TWO_PI)*(random(10, 40)*scale);
    y1 = sin(0 * 0.1 * TWO_PI)*(random(10, 40)*scale);
    float ox = x1;
    float oy = y1;
    for(int i = 1; i < sides; i++){
      x2 = cos(i * 0.1 * TWO_PI)*(random(10, 40)*scale);
      y2 = sin(i * 0.1 * TWO_PI)*(random(10, 40)*scale);
      l = new Line(x1, y1, x2, y2, pos.x, pos.y);
      lines.add(l);
      x1 = x2;
      y1 = y2;
    }
    
    l = new Line(x2, y2, ox, oy, pos.x, pos.y);
    lines.add(l);
  }
}
