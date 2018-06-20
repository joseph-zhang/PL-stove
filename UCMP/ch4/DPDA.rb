# use PDA rules to define DPDA
require_relative 'PDAconfig'

class DPDARulebook < Struct.new(:rules)
  def next_configuration(configuration, character)
    rule_for(configuration, character).follow(configuration)
  end

  # check if there are some rules satisfied
  def rule_for(configuration, character)
    rules.detect {|rule| rule.applies_to?(configuration, character)}
  end

  def applies_to?(configuration, character)
    !rule_for(configuration, character).nil?
  end

  # follow all free moves it can achieve to 
  def follow_free_moves(configuration)
    if applies_to?(configuration, nil)
      follow_free_moves(next_configuration(configuration, nil))
    else
      configuration
    end
  end
end

class DPDA < Struct.new(:current_configuration,
                        :accept_states,
                        :rulebook)
  def current_configuration
    rulebook.follow_free_moves(super)
  end
  
  def accepting?
    accept_states.include?(current_configuration.state)
  end

  def next_configuration(character)
    if rulebook.applies_to?(current_configuration, character)
      rulebook.next_configuration(current_configuration, character)
    else
      current_configuration.set_stuck
    end
  end

  def stuck?
    current_configuration.stuck?
  end
  
  def read_character(character)
    self.current_configuration = (next_configuration(character))
  end

  def read_string(string)
    # code block, use `unless` modifiers
    string.chars.each do |character|
      read_character(character) unless stuck?
    end
  end
end

class DPDADesign < Struct.new(:start_state,
                              :bottom_character,
                              :accept_states,
                              :rulebook)
  def accepts?(string)
    to_dpda.tap {|dpda| dpda.read_string(string)}.accepting?
  end
  
  def to_dpda
    start_stack = Stack.new([bottom_character])
    start_configuration = PDAConfiguration.new(start_state, start_stack)
    DPDA.new(start_configuration, accept_states, rulebook)
  end
end

# ----------------------------------------------------- test code -------------------------------------------------
if __FILE__ == $0
  rulebook = DPDARulebook.new([PDARule.new(1, '(', 2, '$', ['b', '$']),
                               PDARule.new(2, '(', 2, 'b', ['b', 'b']),
                               PDARule.new(2, ')', 2, 'b', []),
                               PDARule.new(2, nil, 1, '$', ['$'])
                              ])
  dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
  puts dpda.accepting? # true
  dpda.read_string('(()')
  puts dpda.accepting? # false
  puts dpda.current_configuration
  dpda.read_character(')')
  puts dpda.current_configuration # free_move occured

  dpda_design = DPDADesign.new(1, '$', [1], rulebook)
  puts dpda_design.accepts?('(((((((((())))))))))') # true
  puts dpda_design.accepts?('()(())((()))(()(()))') # true

  dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
  dpda.read_string('())')
  puts dpda.accepting? # false
  puts dpda.stuck? # true
  puts dpda.current_configuration # stuck occured
end
