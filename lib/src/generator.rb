# frozen-string-literal: true

##
# The main interface for generating passwords.
module Generator
  ##
  # Generates a password using the given length and character set.
  #
  # @raise [ArgumentError] if the length is less than or equal to 0.
  # @raise [ArgumentError] if there are no character sets.
  # @raise [ArgumentError] if one of the character sets is empty.
  # @raise [ArgumentError] if `use_each_character_set?` is `true` and the desired length is less than the number of
  # sets provided.
  #
  # @param length [Integer] The length of the generated string.
  # @param character_sets [Array[Array[String]] The sets of characters to use for generation.
  # @param options [options] Additional options for generation.
  # @return [String] The generated password.
  def self.generate(length:, character_sets:, options: {}.freeze)
    raise ArgumentError, "The length must be a positive, non-zero number." if length.zero? || length.negative?
    raise ArgumentError, "There must be at least one character set." if character_sets.empty?
    raise ArgumentError, "Character sets must not be empty." if character_sets.any?(&:empty?)

    random = options.fetch(:random, Random.new)

    if options.fetch(:use_each_character_set?, false)
      generate_careful random, length: length, character_sets: character_sets
    else
      generate_careless random, length: length, character_set: character_sets.flatten
    end
  end

  ##
  # Generates a string, respecting the number of characters employed from each character set.
  #
  # @param random [Random] The instance of the Random class to use.
  # @param length [Integer] The length of the generated string.
  # @param character_sets [Array[Array[String]] The sets of characters to use for generation.
  # @return [String] The generated password.
  def self.generate_careful(random, length:, character_sets:)
    if length < character_sets.length
      raise ArgumentError, "When employing a member of each character set, the length must be equal or greater " \
        "to the number of character sets used."
    end

    result = []

    character_sets.each do |set|
      character = set[random.rand(set.length)]
      result << character
    end

    remaining_length = length - result.length
    character_set = character_sets.flatten

    remaining_length.times do
      character = character_set[random.rand(character_set.length)]
      result << character
    end

    result.shuffle!.join
  end

  ##
  # Generates a string irrespective to the number of characters used from each character set.
  #
  # @param random [Random] The instance of the Random class to use.
  # @param length [Integer] The length of the generated string.
  # @param character_set [Array[String]] The set of characters to use for generation.
  # @return [String] The generated password.
  def self.generate_careless(random, length:, character_set:)
    character_count = character_set.length

    (Array.new length).map do |_|
      character_set[random.rand(character_count)]
    end.join
  end

  private_class_method :generate_careless
  private_class_method :generate_careful
end
