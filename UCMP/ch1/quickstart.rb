#!/usr/bin/env ruby

# I think the most important part here is object oriented in ruby,
# everthing in ruby is object, and every object has its own methods.
# here is the code define in chapter 1.5 to show this part of ruby

##############################
## basic notion of rb class ##
##############################
# the name of class begins with an uppercase letter
class Calculateor 
  def divide(x, y)
    x / y
  end
end

class MultiplyingCalculator < Calculateor
  def multiply(x, y)
    x * y
  end
end

class BinaryMultiplyingCalculator < MultiplyingCalculator
  def multiply(x, y)
    result = super(x, y)
    result.to_s(2) # the value of result is object
  end
end


###################################
## Ruby basic inner class Struct ##
###################################
class Point < Struct.new(:x, :y)
  def +(another_point)
    Point.new(x + another_point.x,
              y + another_point.y)
  end

  def inspect
    "#<POINT (#{x}, #{y})>" # here we use string insertion
  end
end

# so we can find that ruby object can be expanded
class Point
  def -(another_point)
    Point.new(x - another_point.x,
              y - another_point.y)
  end
end

####################################
## FP can be use here in ruby way ##
####################################

# some funny fp like methods, though is not so strong.
SRANGE = 1..10
SRANGE.count {|number| number.even?}
SRANGE.select {|number| number.even?}
SRANGE.any? {|number| number < 8}

# now you can find that, the code in block is predicate
# there is a easier way to do this
["one", "two", "three"].map(&:upcase)
["one", "two", "three"].map(&:chars)
["one", "two", "three"].flat_map(&:chars)
SRANGE.inject(0) {|result, number| result * number}

(1..5).each do |number|
  if number.even?
    puts "#{number} is even"
  else
    puts "#{number} is odd"
  end
end

