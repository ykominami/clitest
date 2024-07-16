# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in clitest.gemspec
gemspec

gem "bundler", "~> 2.0"
gem "pre-commit"
gem "rake", "~> 13.0"
gem "rb-readline"

# group :test, optional: true do
# end

group :development, :test, optional: true do
  gem "aruba"
  gem "coderay", "~> 1.1.1"
  gem "debug"
  # gem "pry"
  # gem "pry-byebug"
  # gem "pry-stack_explorer"
  gem "rspec", "~> 3.0"
  gem "rspec_junit_formatter"
  gem "rubocop", "~> 1.7"
  gem "rubocop-rake"
  gem "rubocop-rspec"
  gem "rufo"
  gem "yard", "~> 0.9.36"
end
