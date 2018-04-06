#!/usr/bin/env ruby

# construct a toy DSL named "Simple"
# implemented by using big-step semantic
require_relative "./smallstep_semantic"

class Number
  def eval(environment)
    self
  end
end

class Boolean
  def eval(environment)
    self
  end
end

class Variable
  def eval(environment)
    environment[name]
  end
end

class Add
  def eval(environment)
    Number.new(left.eval(environment).value +
               right.eval(environment).value)
  end
end

class Multiply
  def eval(environment)
    Number.new(left.eval(environment).value *
               right.eval(environment).value)
  end
end

class LessThan
  def eval(environment)
    Boolean.new(left.eval(environment).value <
               right.eval(environment).value)
  end
end

class Assign
  def eval(environment)
    environment.merge({name => expression.eval(environment)})
  end
end

class DoNothing
  def eval(environment)
    environment
  end
end

class If
  def eval(environment)
    case condition.eval(environment)
    when Boolean.new(true)
      consequence.eval(environment)
    when Boolean.new(false)
      alternative.eval(environment)
    end
  end
end

class Sequence
  def eval(environment)
    second.eval(first.eval(environment))
  end
end

class While
  def eval(environment)
    case condition.eval(environment)
    when Boolean.new(false)
      DoNothing.new().eval(environment)
    when Boolean.new(true)
      eval(body.eval(environment))
    end
  end
end



# ----------------------------------------------------- test code -------------------------------------------------
if __FILE__ == $0
  statement = Sequence.new(Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
                           Assign.new(:y, Add.new(Variable.new(:x), Number.new(3))))
  puts statement.eval({})

  #puts "\n"

  statement = While.new(LessThan.new(Variable.new(:x), Number.new(5)),
                        Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3))))

  puts statement.eval({x: Number.new(1)})
end
