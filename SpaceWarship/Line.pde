class Line{
  PVector pos1;
  PVector pos2;
  PVector center;
  
  Line(float x, float y, float xx, float yy, float cx, float cy){
    pos1 = new PVector(x, y);
    pos2 = new PVector(xx, yy);
    center = new PVector(cx, cy);
  }
  
  void update(PVector px){
    center = px.copy();
  }
  
  void show(){
    line(center.x + pos1.x, center.y+pos1.y, center.x+pos2.x, center.y+pos2.y);
  }
}
