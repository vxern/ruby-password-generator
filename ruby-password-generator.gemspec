# frozen_string_literal: true

require_relative "lib/ruby/password/generator/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-password-generator"
  spec.version = Ruby::Password::Generator::VERSION
  spec.authors = ["Dorian Oszczęda"]
  spec.email = "vxern@wordcollector.co.uk"

  spec.summary = "A simple password generator."
  spec.description = "A simple password generator."
  spec.homepage = "https://github.com/vxern/ruby-password-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org/",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/vxern/ruby-password-generator",
    "bug_tracker_uri" => "https://github.com/vxern/ruby-password-generator/issues",
    "changelog_uri" => "https://github.com/vxern/ruby-password-generator/blob/main/CHANGELOG.md",
    # "documentation_uri" => "",
    # "mailing_list_uri" => "",
    # "wiki_uri" => "",
    # "funding_uri" => "",
  }

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
