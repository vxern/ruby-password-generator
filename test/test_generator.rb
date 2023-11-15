# frozen-string-literal: true

require_relative "../lib/src/character_set"
require_relative "../lib/src/generator"
require_relative "../lib/password_generator"

require_relative "./utils"

require "minitest/autorun"

class TestGenerator < Minitest::Test
  def test_has_version_number
    refute_nil PasswordGenerator::VERSION
  end

  def test_raises_if_length_is_negative_or_zero
    error = assert_raises do
      Generator.generate length: -1, character_sets: []
    end
    assert_instance_of ArgumentError, error
    assert_equal "The length must be a positive, non-zero number.", error.message

    error = assert_raises do
      Generator.generate length: 0, character_sets: []
    end
    assert_instance_of ArgumentError, error
    assert_equal "The length must be a positive, non-zero number.", error.message
  end

  def test_raises_if_no_character_sets
    error = assert_raises do
      Generator.generate length: 128, character_sets: []
    end
    assert_instance_of ArgumentError, error
    assert_equal "There must be at least one character set.", error.message
  end

  def test_raises_if_any_character_set_is_empty
    error = assert_raises do
      Generator.generate length: 128, character_sets: [[]]
    end
    assert_instance_of ArgumentError, error
    assert_equal "Character sets must not be empty.", error.message
  end

  def test_raises_if_length_does_not_accommodate_for_number_of_character_sets
    error = assert_raises do
      Generator.generate length: 1, character_sets: [
        CharacterSet::ALPHABETICAL_LOWER, CharacterSet::ALPHABETICAL_UPPER
      ], options: { use_each_character_set?: true }
    end
    assert_instance_of ArgumentError, error
    assert_equal "When employing a member of each character set, the length must be equal or greater to the " \
                   "number of character sets used.", error.message
  end

  def test_generates_password_of_given_length
    result = Generator.generate length: 128, character_sets: [CharacterSet::Combined::ALPHABETICAL]
    assert_equal result.length, 128
  end

  def test_generates_password_using_members_of_all_character_sets
    result = Generator.generate length: 4, character_sets: [
      CharacterSet::ALPHABETICAL_LOWER, CharacterSet::ALPHABETICAL_UPPER, CharacterSet::NUMERIC, CharacterSet::SYMBOLS
    ], options: { use_each_character_set?: true }
    characters = result.chars
    assert [character_set_include_one_of?(CharacterSet::ALPHABETICAL_LOWER, characters),
            character_set_include_one_of?(CharacterSet::ALPHABETICAL_UPPER, characters),
            character_set_include_one_of?(CharacterSet::NUMERIC, characters),
            character_set_include_one_of?(CharacterSet::SYMBOLS, characters)].all?
  end
end
