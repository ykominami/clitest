# frozen_string_literal: true

require_relative "clitest/version"
require_relative "clitest/cmdline"
require "pathname"

module Clitest
  BIN_DIR_PN = Pathname.new(__FILE__).parent.parent + "bin"

  class Error < StandardError; end
  # Your code goes here...
end
