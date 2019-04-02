// define a new datatype Num
abstract class NumD {}

// a value of NumD
class Zero extends NumD {}

class OneMoreThan extends NumD{
    NumD predecessor;
    OneMoreThan(NumD _p){
        predecessor = _p;
    }
}

class Main{
    public static void main(String[] args){
        new Zero();
        new OneMoreThan(new Zero());
        new OneMoreThan(new OneMoreThan(new Zero()));
    }
}
