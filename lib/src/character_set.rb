# frozen_string_literal: true

##
# Defines a pre-made selection of commonly used character sets.
class CharacterSet
  ALPHABETICAL_LOWER = ("a".."z").to_a.freeze
  ALPHABETICAL_UPPER = ("A".."Z").to_a.freeze
  NUMERIC = ("0".."9").to_a.freeze
  SYMBOLS = [*"!".."/", *":".."@", *"[".."`", *"{".."~"].freeze

  class Combined
    ALPHABETICAL = ALPHABETICAL_LOWER + ALPHABETICAL_UPPER
    ALPHANUMERIC_LOWER = NUMERIC + ALPHABETICAL_LOWER
    ALPHANUMERIC_UPPER = NUMERIC + ALPHABETICAL_UPPER
    ALPHANUMERIC = NUMERIC + ALPHABETICAL
    NONALPHABETICAL = NUMERIC + SYMBOLS
    ALL = ALPHABETICAL_LOWER + ALPHABETICAL_UPPER + NUMERIC + SYMBOLS
  end
end
