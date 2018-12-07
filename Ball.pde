public class Ball{

  PVector position;
  int colorR;
  int colorG;
  int colorB;
  PVector velocity;
  Table table;
  int dimension;
  boolean alive = true;
  ArrayList<Bar> bosses = new ArrayList();

  public Ball(int positionX, int positionY,
     int colorR, int colorG, int colorB, int dimension, Table table){


    position = new PVector(positionX, positionY);
    this.colorR = colorR;
    this.colorG = colorG;
    this.colorB = colorB;
    velocity = new PVector(0,0);
    this.table = table;
    this.dimension = dimension;

  }

  public void update(){
      if(alive){
      bounce();
      position.x += velocity.x;
      position.y += velocity.y;
      fill(colorR, colorG, colorB);
      ellipse(position.x, position.y, dimension, dimension);
  }

  }

  public void bounce(){
    if(position.x + (dimension/2) >= table.topLeftCorner.x + table.lengthX ||
       position.x - (dimension/2) <= table.topLeftCorner.x){

         velocity.x = -velocity.x;
    }

    if(position.y - (dimension/2) <= table.topLeftCorner.y){

        velocity.y = -velocity.y;
      }

    if (position.y + (dimension/2) >=
    table.topLeftCorner.y + table.lengthY){
      alive = false;
      System.out.println("sono morta");
    }

      for( Bar b : bosses){

        if(position.y >= b.position.y
          && position.x >= b.position.x
          && position.x <= b.position.x+b.lengthX){
            System.out.println("hit");

            velocity.y = -velocity.y;
          }

      }

  }


  public void addBoss(Bar bar){
    bosses.add(bar);
  }


}
