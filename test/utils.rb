# frozen_string_literal: true

def character_set_include_one_of?(character_set, characters)
  character_set.any? { |character| characters.include? character }
end
