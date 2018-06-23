# use PDA rules to define FPDA
# note that configuration can be seen as the states with storage
require 'set'
require_relative 'PDAconfig'

class NPDARulebook < Struct.new(:rules)
  def next_configurations(configurations, character)
    configurations.flat_map {|config| follow_rules_for(config, character)}.to_set
  end

  # go on for all possible path
  def follow_rules_for(configuration, character)
    rules_for(configuration, character).map {|rule| rule.follow(configuration)}
  end

  # find all posiible rules
  def rules_for(configuration, character)
    # note that it is select (filter), not detect (find)
    rules.select {|rule| rule.applies_to?(configuration, character)}
  end

  def follow_free_moves(configurations)
    more_configurations = next_configurations(configurations, nil)
    if more_configurations.subset?(configurations)
      configurations
    else
      # do it recursively
      follow_free_moves(more_configurations + configurations)
    end
  end
end

class NPDA < Struct.new(:current_configurations, :accept_states, :rulebook)
  def accepting?
    current_configurations.any? {|config| accept_states.include?(config.state)}
  end

  def read_character(character)
    self.current_configurations =
      rulebook.next_configurations(current_configurations, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end 
  end

  def current_configurations
    rulebook.follow_free_moves(super)
  end
end

class NPDADesign < Struct.new(:start_state,
                              :bottom_character,
                              :accept_states,
                              :rulebook)
  def accepts?(string)
    to_npda.tap {|npda| npda.read_string(string)}.accepting?
  end

  def to_npda
    start_stack = Stack.new([bottom_character])
    start_configuration = PDAConfiguration.new(start_state, start_stack)
    NPDA.new(Set[start_configuration], accept_states, rulebook)    
  end
end

# ------------------------------------------- test code ------------------------------------
if __FILE__ == $0
  rulebook = NPDARulebook.new([PDARule.new(1, 'a', 1, '$', ['a', '$']),
                               PDARule.new(1, 'a', 1, 'a', ['a', 'a']),
                               PDARule.new(1, 'a', 1, 'b', ['a', 'b']),
                               PDARule.new(1, 'b', 1, '$', ['b', '$']),
                               PDARule.new(1, 'b', 1, 'a', ['b', 'a']),
                               PDARule.new(1, 'b', 1, 'b', ['b', 'b']),
                               PDARule.new(1, nil, 2, '$', ['$']),
                               PDARule.new(1, nil, 2, 'a', ['a']),
                               PDARule.new(1, nil, 2, 'b', ['b']),
                               PDARule.new(2, 'a', 2, 'a', []),
                               PDARule.new(2, 'b', 2, 'b', []),
                               PDARule.new(2, nil, 3, '$', ['$'])])

  configuration = PDAConfiguration.new(1, Stack.new(['$']))
  npda = NPDA.new(Set[configuration], [3], rulebook)
  puts npda.accepting?
  puts npda.current_configurations

  npda.read_string('abb')
  puts npda.accepting?
  puts npda.current_configurations
  npda.read_character('a')
  puts npda.accepting?
  puts npda.current_configurations

  npda_design = NPDADesign.new(1, '$', [3], rulebook)
  puts npda_design.accepts?('abba')
  puts npda_design.accepts?('babbaabbab')
  puts npda_design.accepts?('abb')
  puts npda_design.accepts?('baabaa')
end
