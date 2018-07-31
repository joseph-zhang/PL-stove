// new point definition
// show more details of point class

abstract class PointD{
    int x;
    int y;

    PointD(int _x, int _y){
	x = _x;
	y = _y;
    }

    boolean closerToO(PointD p){
	return distanceToO() <= p.distanceToO();
    }
    abstract int distanceToO();
}

class CartesianPt extends PointD {
    CartesianPt(int _x, int _y){
        super(_x, _y);
    }
    
    int distanceToO(){
        return (int)Math.sqrt(x*x + y*y);
    }
}

class ManhattanPt extends PointD{
    ManhattanPt(int _x, int _y){
        super(_x, _y);
    }

    int distanceToO(){
	return x + y;
    }
}

class Main{
    public static void main(String[] args){
	PointD p1 = new ManhattanPt(2, 3);
	PointD p2 = new CartesianPt(3, 4);

	System.out.println(p1);
	System.out.println(p2);

	System.out.println(p1.closerToO(p2));
    }
}
