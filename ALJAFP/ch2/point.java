// add methods for classes

abstract class PointD{
    abstract int distanceToO();
}

class CartesianPt extends PointD{
    int x;
    int y;
    
    CartesianPt(int _x, int _y){
	x = _x;
	y = _y;
    }

    public String toString(){
	return "new" + getClass().getName()
	    + "(" + x + ", " + y + ")";
    }
	
    int distanceToO(){
	return (int)Math.sqrt(x*x + y*y);
    }
}

class ManhattanPt extends PointD{
    int x;
    int y;
    
    ManhattanPt(int _x, int _y){
	x = _x;
	y = _y;
    }
    
    public String toString(){
	return "new" + getClass().getName()
	    + "(" + x + ", " + y + ")";
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
	System.out.println(p1.distanceToO());
	System.out.println(p2);
	System.out.println(p2.distanceToO());
    }
}
