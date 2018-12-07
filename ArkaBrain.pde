
//SETTINGS
int SCALINGFACTOR = 1;
int FIRSTGENERATION = 8000;
int OTHERGENERATION = 600;
float MUTATIONRATE = 0.25;


Table tavolo = new Table(200/SCALINGFACTOR,100/SCALINGFACTOR,2700/SCALINGFACTOR,1500/SCALINGFACTOR);
ArrayList<Bar> pool = new ArrayList();
ArrayList<Bar> deathCollector = new ArrayList();
Bar best;
int generationCounter = 0;
float scoreCounter = 0;
float maxScore = 0;

public void settings() {
    size((int)3100/SCALINGFACTOR,(int)1800/SCALINGFACTOR);
}

void setup(){

  spawnGeneration(FIRSTGENERATION);


}

void draw(){

  background(255);
  tavolo.update();
  for(Bar barra: pool){

    barra.update();
    if(!barra.isAlive()){
      deathCollector.add(barra);
    }
  }

  cleanUp();
  if(pool.size()==0){
    spawnGeneration(OTHERGENERATION,best,MUTATIONRATE);
    if(scoreCounter>maxScore){
      maxScore = scoreCounter;
    }
    scoreCounter = 0;
    generationCounter++;

  }


  scoreCounter+=0.1;

  String status = ("generation :"+generationCounter+'\n'+"score: "+(int)scoreCounter+'\n'+"maxScore: "+(int)maxScore+'\n');
fill(255,255,255);
textSize(200/SCALINGFACTOR);
text(status, 200/SCALINGFACTOR, 300/SCALINGFACTOR);


}

/*void keyPressed(){
    switch(keyCode){
      case LEFT:
        barra.moveL();
        break;
      case RIGHT:
        barra.moveR();
        break;
    }

  }*/

void spawnGeneration(int n){

  for(int i=0; i<=n; i++){
    pool.add(new Bar((int)tavolo.topLeftCorner.x+tavolo.lengthX/2,
       (int)tavolo.topLeftCorner.y+tavolo.lengthY-50/4,
       200/4, 50/4,
       0, 255,  0,
       tavolo));
  }

}

void spawnGeneration(int n, Bar best, float mutationRate){
  pool.add(best);
  for(int i=0; i<=n; i++){
    NeuralNetwork bestBrain = best.brain.copy();
    bestBrain.mutate(mutationRate);
    Bar nuovo = new Bar((int)tavolo.topLeftCorner.x+tavolo.lengthX/2,
       (int)tavolo.topLeftCorner.y+tavolo.lengthY-50/4,
       200/4, 50/4,
       0, 255,  0,
       tavolo);
    nuovo.mountBrain(bestBrain);
    pool.add(nuovo);
  }

}


void cleanUp(){
  for(Bar b:deathCollector){
    if(pool.size()==1){
      best = b;
    }
    pool.remove(b);
  }
}
