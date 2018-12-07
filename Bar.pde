public class Bar{

  PVector position;
  int lengthX;
  int lengthY;
  int colorR;
  int colorG;
  int colorB;
  Ball ball;
  Table table;
  NeuralNetwork brain;


  public Bar(int positionX, int positionY,
     int lengthX, int lengthY,
     int colorR, int colorG, int colorB,
     Ball ball, Table table){
       position = new PVector(positionX, positionY);
       this.colorR = colorR;
       this.colorG = colorG;
       this.colorB = colorB;
       this.ball = ball;
       this.table = table;
       this.lengthX = lengthX;
       this.lengthY = lengthY;
       brain = new NeuralNetwork(3,6,2);

     }

     public Bar(int positionX, int positionY,
        int lengthX, int lengthY,
        int colorR, int colorG, int colorB,
        Table table){
          position = new PVector(positionX, positionY);
          this.colorR = colorR;
          this.colorG = colorG;
          this.colorB = colorB;
          this.table = table;
          this.ball = new Ball((int)(this.table.topLeftCorner.x+random(100/SCALINGFACTOR,600/SCALINGFACTOR)),
            (int)(this.table.topLeftCorner.y+random(100/SCALINGFACTOR,600/SCALINGFACTOR)),255,0,0,50/SCALINGFACTOR,table);
          this.ball.velocity = new PVector(pow(-1,(int)random(0,2))*20/SCALINGFACTOR,pow(-1,(int)random(0,2))*20/SCALINGFACTOR);
          this.ball.addBoss(this);
          this.lengthX = lengthX;
          this.lengthY = lengthY;
          brain = new NeuralNetwork(3,6,2);

        }

     public void update(){
       if(isAlive()){

         fill(colorR, colorG, colorB);
         rect(position.x, position.y, lengthX, lengthY);
         ball.update();
         double[] inputs = {position.x, ball.position.x, ball.position.y };
         double[] outputs = brain.feedforward(inputs);

         if(outputs[0] == 1){
           moveL();
         }

         if(outputs[1] == 1){
           moveR();
         }
       }

     }

     public void moveL(){
       this.position.x -= 25/SCALINGFACTOR;
       if(this.position.x  < table.topLeftCorner.x ){
         this.position.x =   table.topLeftCorner.x ;
       }
     }

     public void moveR(){
       this.position.x += 25/SCALINGFACTOR;
       if(this.position.x + lengthX > table.topLeftCorner.x + table.lengthX){
         this.position.x = -lengthX + table.topLeftCorner.x + table.lengthX;
       }
     }

     public void mountBrain(NeuralNetwork brain){
       this.brain = brain;
     }

     public boolean isAlive(){
       return ball.alive;
     }

}
