#!usr/bin/env ruby
# A simple Regular Expression engine
# It supports three basic syntax: 'a|b', '(x)*' and Equal matching
require_relative 'free_move'
require 'treetop'

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
  # mixin
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
  # mixin
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
  #mixin
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

    # add free move between two stages
    extra_rules = first_nfa_design.accept_states.map {|state|
      FARule.new(state, nil, second_nfa_design.start_state)
    }
    rulebook = NFARulebook.new(rules + extra_rules)
    NFADesign.new(start_state, accept_states, rulebook)
  end
end

# type4: (a|b)
class Choose < Struct.new(:first, :second)
  # mixin
  include Pattern

  def to_s
    [first, second].map {|pattern| pattern.bracket(precedence)}.join('|')
  end

  def precedence
    0
  end

  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = Object.new
    accept_states = first_nfa_design.accept_states + second_nfa_design.accept_states
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    extra_rules = [first_nfa_design, second_nfa_design].map {|nfa_design|
      FARule.new(start_state, nil, nfa_design.start_state)
    }
    rulebook = NFARulebook.new(rules + extra_rules)

    NFADesign.new(start_state, accept_states, rulebook)
  end
end

# type5: (x)* 
class Repeat < Struct.new(:pattern)
  # mixin
  include Pattern

  def to_s
    pattern.bracket(precedence) + '*'
  end

  def precedence
    2
  end

  def  to_nfa_design
    # old NFA machine
    pattern_nfa_design = pattern.to_nfa_design
    # a new start state
    start_state = Object.new
    # all accept states, start state is also an accept state
    accept_states = pattern_nfa_design.accept_states + [start_state]

    rules = pattern_nfa_design.rulebook.rules
    # some extra rules: free move
    extra_rules = pattern_nfa_design.accept_states.map {|state|
      FARule.new(state, nil, pattern_nfa_design.start_state)
    } + [FARule.new(start_state, nil, pattern_nfa_design.start_state)]

    rulebook = NFARulebook.new(rules + extra_rules)
    NFADesign.new(start_state, accept_states, rulebook)
  end
end 


# ----------------------------------------------------- test code ----------------------------------------------
if __FILE__ == $0
  Treetop.load('regEXP')
  parse_tree = PatternParser.new.parse('(a(|b))*')
  puts parse_tree
  pattern = parse_tree.to_ast
  puts pattern
  puts pattern.matches?('abaab')
  puts pattern.matches?('abaac')
end
