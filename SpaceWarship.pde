import co.jimezam.util.Dialogo;
import ddf.minim.*;
Minim minim;
AudioPlayer player,player2;
/*
se importa la libreria oscp5 para iniciar la interaccion 
con pureData
*/
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
//---OSCP5
boolean sonido_ON = false;
//variables..
int tamano_cuadros = 20;
int tamano = 40;
color bodyColor = #6E0595;
PImage nave;
int score;
int ballSize = 40;
boolean fire = false;
int gameOver = 0;

int cent = 30;

  int getRandomX(){
    return int(random(400));
  }
  
  int[] ballx = { getRandomX(), 
                  getRandomX(), 
                  getRandomX(), 
                  getRandomX(), 
                  getRandomX() 
                 };
  int[] bally = {0,0,0,0,0};      

int numCuadros = 4          ;
int numCuadros_3D = int(random(100,40));
int velY1 = 5;

float [] ballX = new float [numCuadros];
float [] ballY = new float [numCuadros];
float [] velX = new float [numCuadros];
float [] velY = new float [numCuadros];

int[] posX_3D; 
int[] posY_3D;

color relleno_disparos = color (random(255),random(255),random(255));
int relleno = relleno_disparos;
//fin de las variables


void setup(){
  minim=new Minim(this);
  player=minim.loadFile("laser");
  player2=minim.loadFile("explosion");
  size(500,600);
  smooth();
  nave=loadImage("nave.png");      
  
 for(int i=0; i<numCuadros; i++){
    ballX[i] = width;
    ballY[i] = height;
    velX[i] = random(1,2);
    velY[i] = random(1,2);
  }

posX_3D = new int [numCuadros_3D];
posY_3D = new int [numCuadros_3D];

for(int contador = 0; contador < numCuadros_3D; contador++){
    posX_3D[contador] = (int)random(width);
    posY_3D[contador] = (int)random(height);
  }
  //mis propiedades oscp5 
  
  oscP5 = new OscP5(this,12000); //tomamos el puerto 12000
  myRemoteLocation = new NetAddress("127.0.0.1",12001);
  
  
}//-----------------------------------aqui termina mi SETUP;

void draw(){
  println("los mandos del juegos son ESPACIO: para tirar las balas y A para pausar el juego.");
  background(90,90,90);
  text("Puntuacion: "+ score, width/20, height/20);
  cuadro(0,0);
  triangulo(0,0);
  
  text(score, 20,20);
  
     if(fire)
    {
      cannon(mouseX);
      fire = false;
    }
    ballFalling();
    fin_juego(); 
  
 for(int i=0; i<numCuadros; i++){
 ballX[i] += velX[i];
 ballY[i] = ballY[i] + velY1;
    if(ballY[i] > 600){
      ballY[i] = 100;
      ballY[i] = int(randomGaussian() * 100);
    }
   if((ballX[i]<0)||(ballX[i]>width)){
      velX[i] = -velX[i];
    }
  }
  
 for (int contador = 0; contador < numCuadros_3D; contador++){
      noFill();
      strokeWeight(1);
      stroke(255);
      rotateY(0.10);
      rotateX(0.5);
      rect(posX_3D[contador]-mouseX/5,posY_3D[contador]-mouseY/20,5,5);
 }
 
  float [] distancia_circulos;
  float magnitud_distancia;
  boolean colision = false;
  distancia_circulos = new float[2];
  
  for (int i=0; i<numCuadros; i++){
    
    distancia_circulos[0] = ballX[i] - mouseX;
    distancia_circulos[1] = ballY[i] - mouseY;
    
    magnitud_distancia = distancia_circulos[0]*
                         distancia_circulos[0]+
                         distancia_circulos[1]*
                         distancia_circulos[1];
    magnitud_distancia = sqrt(magnitud_distancia);
    if(magnitud_distancia < tamano_cuadros*2){
    
      
      colision = true;
      Dialogo.mostrar("","Perdiste", Dialogo.TIPO_ADVERTENCIA);
      score = 0;
      break;
      
    }
  }
   if(colision){
      for(int i=0; i<numCuadros; i++){
      setup();
      }
    }
    
    //mis propiedades de oscP5
      OscMessage mousex = new OscMessage("mouseX");
      OscMessage mousey = new OscMessage("mouseY");
      
      mousex.add(mouseX);
      mousey.add(mouseY);
 
      oscP5.send(mousex, myRemoteLocation);
      oscP5.send(mousey, myRemoteLocation); 
    
}//------------------------------- aqui termina mi DRAW;
void keyReleased() {

    if(keyCode == 32/*SPACE*/ ){
        fire = true;
        sonido_ON = true;
       OscMessage disparo = new OscMessage("disparo");
       disparo.add(sonido_ON);
       oscP5.send(disparo, myRemoteLocation);
       player.play();
    }
    if(keyCode == 65 /*letra A*/){
      Dialogo.mostrar("","Pausa", Dialogo.TIPO_ADVERTENCIA);//pausa el juego
     }

  }
  
void ballFalling()
  { 
 fill(38,178,170);
 smooth();
 strokeWeight(5);
 stroke(255);
    for (int i=0; i<5; i++)
    {
      ellipse(ballx[i], bally[i]++,tamano,tamano);
    }
  }

void cannon(int shotX)
  {
    boolean strike = false;
    for (int i = 0; i <5; i++)
    {
      if((shotX >= (ballx[i]-tamano/2)) && 
         (shotX <= (ballx[i]+tamano/2))){
        strike = true;
        line(mouseX,400, mouseX, 10);
        ellipse(ballx[i], bally[i],
                tamano+25, tamano+25);
        ballx[i] = getRandomX();
        bally[i] = 0;
// carga es puntaje
        score++;
        player2.play();
      }   
    }
   
    if(strike == false)
    {
 fill(255,555,555);
 smooth();
 strokeWeight(5);
 stroke(255);
 line(mouseX,mouseY, mouseX,10);
    } 
   
  }
//GameOver
  void fin_juego()
  {
    for (int i=0; i< 5; i++)
    {
      if(bally[i]==600)
      { 
    fill(color(255,0,0));
    fill(255, 0, 0);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    text("tu puntuacion es : "+ score, width/2, height/2 + 100);
    noLoop();    
       }
      }
    }
  
void mousePressed(){

for(int contador = 0; contador < numCuadros_3D; contador++){
    posX_3D[contador] = (int)random(width);
    posY_3D[contador] = (int)random(height);
  }
}

void cuadro(int x, int y)
{
  for(int i=0; i<numCuadros; i++){
      fill(3,3,3);
      strokeWeight(5);
      stroke(255,0,0);
      ellipse(ballX[i],ballY[i],tamano_cuadros,tamano_cuadros);
      ellipse(ballX[i]-1,ballY[i]-mouseY/-20,5,5);
      ellipse(ballX[i]+random(-10,5),ballY[i]+random(-10,5),1,1);
  }
}

void triangulo(int x, int y)
{
 image(nave,mouseX-cent,mouseY,60,60);
 tint(0,50);
 image(nave,mouseX+10,mouseY,50,50);
 noTint();
}

  
