#!usr/bin/env ruby

# a simple simulation of DFA(Deterministic Finite Automaton)

class FARule < Struct.new(:state, :character, :next_state)
  def applies_to?(state, character)
    self.state == state && self.character == character
  end

  def follow
    next_state
  end
end


class DFARulebook < Struct.new(:rules)
  def next_state(state, character)
    rule_for(state, character).follow
  end

  def rule_for(state, character)
    rules.detect {|rule| rule.applies_to?(state, character)} 
  end
end


class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def to_s
    "<DFAitem current_state=#{current_state}, accept_states=#{accept_states}>"
  end
  
  def inspect
    "#{self}"
  end
  
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each {|character| read_character(character)}
  end
end


class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_dfa
    DFA.new(start_state, accept_states, rulebook)
  end

  def accpts?(string)
    to_dfa.tap {|dfa| dfa.read_string(string)}.accepting?
  end
end

# ------------------------------------------------ test code ------------------------------------------------
if __FILE__ == $0
  rulebook = DFARulebook.new([FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
                              FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
                              FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)])
  puts dfa = DFA.new(1, [3], rulebook); puts dfa.accepting?
  "baaab".chars.each {|c| puts c; dfa.read_character(c); puts dfa}
  puts dfa.accepting?
end
