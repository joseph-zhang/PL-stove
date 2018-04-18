#!usr/bin/env ruby
# free move method for multi-pattern

require'./NFA_stimulate.rb'

# add new method for NFA class
class NFARulebook
  def follow_free_moves(states)
    more_states = next_states(states, nil)
    if more_states.subset?(states)
      states
    else
      follow_free_moves(states + more_states) # here, the operator '+' means combine
    end
  end
end

class NFA
  def current_states
    rulebook.follow_free_moves(super)
  end  
end

# ---------------------------------------------- test code -------------------------------------------------

rulebook = NFARulebook.new([FARule.new(1, nil, 2), FARule.new(1, nil, 4),
                            FARule.new(2, 'a', 3), FARule.new(3, 'a', 2),
                            FARule.new(4, 'a', 5), FARule.new(5, 'a', 6),
                            FARule.new(6, 'a', 4)])

if __FILE__ == $0
  nfa_design = NFADesign.new(1, [2,4], rulebook)
  puts nfa_design.accepts?('aa')
  puts nfa_design.accepts?('aaa')
  puts nfa_design.accepts?('aaaaa')
  puts nfa_design.accepts?('aaaaaa')
end
