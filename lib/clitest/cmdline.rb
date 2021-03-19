# frozen_string_literal: true

module Clitest
  require "pathname"

  class Cmdline
    attr_reader :test_cmd_path_pn

    CMD = "cmd.sh"

    def initialize(bin_dir, cmd_name, test_dir, *target_cmds)
      if bin_dir =~ /^\s*$/
        bin_dir = nil
      end
      if bin_dir
        bin_dir_pn = Pathname.new(bin_dir)
        bin_dir_pn = nil unless bin_dir_pn.exist?
      end
      bin_dir_pn = BIN_DIR_PN unless bin_dir_pn

      if cmd_name == nil
	      cmd_name = CMD
      end
      @test_cmd_path_pn = bin_dir_pn + cmd_name
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
