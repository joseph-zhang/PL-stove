#!usr/bin/env ruby
# A simple Regular Expression engine
# It supports three basic syntax: 'a|b', '(x)*' and Equal matching
require_relative 'DFA_simulate'


module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      '(' + to_s + ')'
    else
      to_s
    end
  end

  def inspect
    "/#{self}/"
  end

  def matches?(string)
    to_nfa_design.accepts?(string)
  end
end

# type1: an empty str
class Empty
  include Pattern

  def to_s
    ''
  end

  def precedence
    3
  end

  def to_nfa_design
    start_state = Object.new
    accept_states = [start_state]
    rulebook = NFARulebook.new([])

    NFADesign.new(start_state, accept_states, rulebook)
  end
end

# type2: only one character
class Literal < Struct.new(:character)
  include Pattern

  def to_s
    character
  end

  def precedence
    3
  end

  def to_nfa_design
    start_state = Object.new
    accept_state = Object.new

    rule = FARule.new(start_state, character, accept_state)
    rulebook = NFARulebook.new([rule])

    NFADesign.new(start_state, [accept_state], rulebook)
  end
end

# type3: (ab)
class Concatenate < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map {|pattern| pattern.bracket(precedence)}.join
  end

  def precedence
    1
  end

  # combine machines!!
  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = first_nfa_design.start_state
    accept_states = second_nfa_design.accept_states

    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
  end
end

# type4: (a|b)
class Choose < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map {|pattern| pattern.bracket(precedence)}.join('|')
  end

  def precedence
    0
  end
end

# type5: (x)* 
class Repeat < Struct.new(:pattern)
  include Pattern

  def to_s
    pattern.bracket(precedence) + '*'
  end

  def precedence
    2
  end
end


  
