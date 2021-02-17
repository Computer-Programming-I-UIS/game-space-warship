Asteroid a;
Ship ship;
ArrayList<Asteroid> asteroids;

void setup(){
  size(800, 600);
  asteroids = new ArrayList<Asteroid>();
  createAsteroids();
  ship = new Ship(width*.5, height*.5);
}

void draw(){
  background(0);
  if (asteroids.size() > 0){
    for(Asteroid a: asteroids){
      a.show();
      a.update();
    }
  }
  else{
    createAsteroids();
  }
  ship.show();
  ship.update();
}

void createAsteroids(){
    for(int i = 0; i < 4; i++){
    a = new Asteroid(random(width), random(height), 10);
    asteroids.add(a);
  }
}
