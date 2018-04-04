#!/usr/bin/env ruby

# construct a toy DSL named "Simple"
# implemented by using small-step semantic

class Number < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    false
  end 
end

class Boolean < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    false
  end
end

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "<<#{self}>>"
  end
  
  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end
end

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end
end

class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    environment[name]
  end
end

class StateMachine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end

class ExpMachine < Struct.new(:expression, :environment)
  def step
    self.expression = expression.reduce(environment)
  end

  def run
    while expression.reducible?
      puts expression
      step
    end
    puts expression
  end
end

class Machine
  def self.new(syntax, *args)
    machine_class = case syntax
                    when Add, Boolean, LessThan, Multiply, Number, Variable
                      ExpMachine
                    when Assign, DoNothing, If, Sequence, While
                      StateMachine
                    else
                      raise "Unexpected Syntax error: #{syntax.inspect}"
                    end
    machine_class.new(syntax, *args)
  end
end

class DoNothing
  def to_s
    'do-nothing'
  end

  def inspect
    "<<#{self}>>"
  end
  
  def ==(another_statement)
    another_statement.instance_of?(DoNothing)
  end

  def reducible?
    false
  end
end

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({name => expression})]
    end
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition # pattern matching
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
    end 
  end
end

class Sequence < Struct.new(:first, :second)
  def to_s
    "#{first}, #{second}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    case first
    when DoNothing.new
      [second, environment]
    else
      reduced_first, reduced_environment = first.reduce(environment)
      [Sequence.new(reduced_first, second), reduced_environment]
    end
  end
end

class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) {#{body}}"
  end

  def inspect
    "#{self}"
  end

  def reducible?
    true
  end

  def reduce(environment)
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end
end


# ------------------------------------------ test code --------------------------------------------------
if __FILE__ == $0
  Machine.new(Add.new(Multiply.new(Number.new(1), Number.new(2)),
                      Multiply.new(Number.new(3), Number.new(4)))).run
  puts "\n"
  
  Machine.new(LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2)))).run

  puts "\n"

  Machine.new(Add.new(Variable.new(:x), Variable.new(:y)),
              {x: Number.new(3), y: Number.new(4)}).run

  puts "\n"

  Machine.new(Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
              {x: Number.new(2)}).run
  
  puts "\n"

  Machine.new(If.new(Variable.new(:x),
                     Assign.new(:y, Number.new(1)),
                     Assign.new(:y, Number.new(2))),
              {x: Boolean.new(true)}).run

  puts "\n"

  Machine.new(Sequence.new(Assign.new(:x, Add.new(Number.new(1), Number.new(2))),
                           Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))),
              {}).run
  puts "\n"

  Machine.new(While.new(LessThan.new(Variable.new(:x), Number.new(5)),
                        Assign.new(:x,
                                   Multiply.new(Variable.new(:x), Number.new(3)))),
                        {x: Number.new(1)}).run
end
