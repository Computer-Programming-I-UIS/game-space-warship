boolean onSegment(PVector p, PVector q, PVector r){
  if((q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) && q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y))){
  return true;
  }
  return false;
}

int orientation(PVector p, PVector q, PVector r){
    float val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    if(val == 0){return 0;}  // colinear
    if(val>0){return 1;}
    else{return 2;}
}
  
boolean doIntersect(float a1x1, float a1y1, float a1x2, float a1y2, float a2x1, float a2y1, float a2x2, float a2y2){
    
    PVector p1 = new PVector(a1x1, a1y1);
    PVector q1 = new PVector(a1x2, a1y2);
    PVector p2 = new PVector(a2x1, a2y1);
    PVector q2 = new PVector(a2x2, a2y2);
    
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
    
    if (o1 != o2 && o3 != o4){
        return true;
    }
    if (o1 == 0 && onSegment(p1, p2, q1)){
      return true;
    }
 
    if (o2 == 0 && onSegment(p1, q2, q1)){
        return true;
    }
 
    if (o3 == 0 && onSegment(p2, p1, q2)){
      return true;
    }
 
    if (o4 == 0 && onSegment(p2, q1, q2)){
      return true;
    }
 
    return false; 
}
