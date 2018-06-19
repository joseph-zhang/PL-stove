# a 'orig' stack

class Stack < Struct.new(:contents)
  def push(character)
    Stack.new([character] + contents)
  end

  def pop
    Stack.new(contents.drop(1))
  end

  def top
    contents.first
  end

  def inspect
    "#<Stack (#{top} )#{contents.drop(1).join}>"
  end
end


# ----------------------------------------------- test code -------------------------------------------
if __FILE__ == $0
  stack = Stack.new(['a', 'b', 'c', 'd', 'e'])
  puts stack.top
  puts stack.pop.pop.top
  puts stack.push('x').push('y').top
end
