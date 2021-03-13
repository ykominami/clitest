# frozen_string_literal: true

module Clitest
  require "pathname"

  class Cmdline
    def initialize(test_data_dir, target_cmd_1, target_cmd_2)
      bin_pn = "#{Pathname.new(__FILE__).parent.parent}bin"
      @test_cmd_path_pn = "#{bin_pn}cmd.sh"
      @test_data_dir_pn = Pathname.new(test_data_dir)
      @target_cmd = []
      @target_cmd << target_cmd_1
      @target_cmd << target_cmd_2
    end

    def make_cmdline_base(target_cmd, target_dir, result, optionx, *param_names)
      params = param_names.join(" ")

      "#{@test_cmd_path_pn} #{@test_data_dir_pn} #{result} #{target_cmd} #{target_dir} #{optionx} #{params}"
    end

    def make_cmdline(cmd_index, target_dir, result, optionx, *param_names)
      make_cmdline_base(@target_cmd[cmd_index], target_dir, result, optionx, *param_names)
    end

    def make_cmdline_1(target_dir, result, optionx, *_param_name)
      make_cmdline(0, @target_cmd_2, target_dir, result, optionx, *param_names)
    end

    def make_cmdline_2(target_dir, result, optionx, *_param_name)
      make_cmdline(1, target_dir, result, optionx, *param_names)
    end
  end
end
