# frozen_string_literal: true

module Clitest
  require "pathname"

  class Cmdline
    CMD = "cmd.sh"
    BIN_DIR = "bin"

    def initialize(test_dir, *target_cmds)
      bin_pn = Pathname.new(__FILE__).parent.parent.parent + BIN_DIR
      @test_cmd_path_pn = bin_pn + CMD
      @test_dir_pn = Pathname.new(test_dir)
      @target_cmd = target_cmds
    end

    def make_cmdline_base(target_cmd, target_dir, result, optionx, *param_names)
      params = param_names.join(" ")

      "#{@test_cmd_path_pn} #{@test_dir_pn} #{result} #{target_cmd} #{target_dir} #{optionx} #{params}"
    end

    def make_cmdline(cmd_index, target_dir, result, optionx, *param_names)
      make_cmdline_base(@target_cmd[cmd_index], target_dir, result, optionx, *param_names)
    end

    def make_cmdline_1(target_dir, result, optionx, *param_name)
      make_cmdline(0, target_dir, result, optionx, param_name)
    end

    def make_cmdline_2(target_dir, result, optionx, *param_name)
      make_cmdline(1, target_dir, result, optionx, param_name)
    end
  end
end
