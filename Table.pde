public class Table{

  PVector topLeftCorner;
  int lengthX;
  int lengthY;

  public Table(int topLeftCornerX, int topLeftCornerY,
    int lengthX, int lengthY){

      topLeftCorner = new PVector(topLeftCornerX, topLeftCornerY);
      this.lengthX = lengthX;
      this.lengthY = lengthY;


     }

     public void update(){
       fill(0);
       rect(topLeftCorner.x, topLeftCorner.y, lengthX, lengthY);

     }

}
