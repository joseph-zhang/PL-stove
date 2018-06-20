# define PDA rule for DPDA and FPDA
# note that PDA: PushDown Automaton
require_relative 'stack'

class PDAConfiguration < Struct.new(:state, :stack)
  STUCK_STATE = Object.new()

  def set_stuck
    PDAConfiguration.new(STUCK_STATE, stack)
  end
  
  def stuck?
    state == STUCK_STATE
  end
end

class PDARule < Struct.new(:state, :character, :next_state,
                       :pop_character, :push_characters)

  def applies_to?(configuration, character)
    self.state == configuration.state &&
      self.pop_character == configuration.stack.top &&
      self.character == character
  end

  def follow(configuration)
    PDAConfiguration.new(next_state, next_stack(configuration))
  end

  def next_stack(configuration)
    popped_stack = configuration.stack.pop

    # fold the stack
    push_characters.reverse.
      inject(popped_stack) {|stack, character| stack.push(character)}
  end
  
end

# --------------------------------------------------- test code ----------------------------------------------
if __FILE__ == $0
  rule = PDARule.new(1, '(', 2, '$', ['b', '$'])
  configuration = PDAConfiguration.new(1, Stack.new(['$']))
  puts rule.applies_to?(configuration, '(')
end
