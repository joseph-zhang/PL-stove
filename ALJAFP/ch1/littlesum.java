// `abstract class` introduces a datatype
// `class` introduces a variant
// `extends` connects a variant to a datatype

abstract class PointD{}

class CartesianPt extends PointD{
    int x;
    int y;
    CartesianPt(int _x, int _y){
	x = _x;
	y = _y;
    }
}

class ManhattanPt extends PointD{
    int x;
    int y;
    ManhattanPt(int _x, int _y){
	x = _x;
	y = _y;
    }
}

abstract class LayerD{}

class Base extends LayerD{
    Object o;
    Base(Object _o){
	o = _o;
    }
}

class Slice extends LayerD{
    LayerD l;
    // note that things created with `new` are Objects
    Slice(LayerD _l){
	l = _l;
    }
}

class Main{
    public static void main(String[] args){
	new ManhattanPt(2, 3);
	new CartesianPt(2, 3);
	new Base(
	 new Boolean(false));
    }
}
