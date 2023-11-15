# Ruby::Password::Generator

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-password-generator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-password-generator

## Requirements

- Ruby 2.6+

## Usage

### Basic usage

To generate a password, call `PasswordGenerator.generate`, specifying the desired length of the password and providing
the sets of characters to use for character selection.

The following example will generate a 128-character-long password consisting of a random selection of
characters `a-z`, `A-Z` and `0-9`.

```ruby
PasswordGenerator.generate(
  length: 128,
  character_sets: [CharacterSet::Combined::ALPHANUMERIC]
)
```

To ensure that at least one character is used from every set of characters passed into the method, pass `options` with
the symbol `:use_each_character_set?` mapped as `true`:

```ruby
PasswordGenerator.generate(
  length: 32,
  character_sets: [CharacterSet::Combined::ALPHABETICAL, CharacterSet::Combined::NUMERIC, ["!"], ["?"]],
  options: { use_each_character_set?: true }
)
```

The above example will generate a password consisting of at least 1 letter, at least 1 number, at least 1 exclamation
mark and at least 1 question mark.

For more information about character sets, read the next section.

### Character sets

The `character_sets` parameter accepts arrays of characters called "character sets". During generation, the gem will
select characters at random from these sets. Configuring character sets is quite flexible, and the only requirement is
that a character set consist solely of singular characters.

For example, the configuration for generating a password consisting solely of letters `x` and `o` and numbers `0`
and `1` can be created as follows.

    PasswordGenerator.generate(
      length: 128,
      character_sets: [["x", "o"], ["0", "1"]]
    )

Out of the box, the gem provides a utility `CharacterSet` class, which features several common, basic character
sets:

- `ALPHABETICAL_LOWER`
- `ALPHABETICAL_UPPER`
- `NUMERIC`
- `SYMBOLS`

There are also a couple of set combinations featured in `CharacterSets::Combined`:

- `ALPHABETICAL` ~~ `ALPHABETICAL_LOWER` + `ALPHABETICAL_UPPER`
- `ALPHANUMERIC_LOWER` ~~ `NUMERIC` + `ALPHABETICAL_LOWER`
- `ALPHANUMERIC_UPPER` ~~ `NUMERIC` + `ALPHABETICAL_UPPER`
- `ALPHANUMERIC` ~~ `NUMERIC` + `ALPHABETICAL`
- `NONALPHABETICAL` ~~ `NUMERIC` + `SYMBOLS`
- `ALL` ~~ `ALPHABETICAL_LOWER` + `ALPHABETICAL_UPPER` + `NUMERIC` + `SYMBOLS`

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
