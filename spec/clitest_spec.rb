# frozen_string_literal: true

require "spec_helper"
require "pathname"

RSpec.describe Clitest do
  let(:spec_dir_pn) { Pathname.new(__FILE__).parent }
  let(:spec_dir) { top_dir_pn.to_s }
  let(:top_dir_pn) { spec_dir_pn.parent }
  let(:top_dir) { top_dir_pn.to_s }
  let(:test_dir_pn) { spec_dir_pn + "test" }
  let(:test_dir) { test_dir_pn.to_s }
  let(:bin_dir_pn) { top_dir_pn + "bin" }
  let(:bin_dir) { bin_dir_pn.to_s }
  let(:test_cmd_1) { "ls" }
  let(:test_cmd_2) { "data" }
  let(:result) { "result.txt" }
  let(:optionx) { nil }
  let(:param_name) { nil }

  let(:cmdline_0) { Clitest::Cmdline.new(bin_dir, nil, test_dir, test_cmd_1, test_cmd_2) }
  it "has a version number" do
    expect(Clitest::VERSION).not_to be nil
  end

  it "has test_cmd" do
    expect(cmdline_0.test_cmd_path_pn.to_s).to include("/home/ykominami/repo/clitest/bin/cmd.sh")
  end

  context "create instance of class" do
    context "Cmdline" do
      before(:each) do
        @cmdline = Clitest::Cmdline.new(bin_dir, nil, test_dir)
      end
      it "create instance" do
        expect(@cmdline).not_to eq(nil)
#        expect(@cmdline).to eq(nil)
      end
    end
  end

  context "make argument" do
    before(:each)  do
      target_1_dir = "cmd1"
      target_2_dir = "cmd2"
      @ret_cmd_0 = cmdline_0.make_cmdline_base(test_cmd_1, target_1_dir, result, optionx, param_name)
      @ret_cmd_1 = cmdline_0.make_cmdline_1(target_1_dir, result, optionx, param_name)
      @ret_cmd_2 = cmdline_0.make_cmdline_2(target_2_dir, result, optionx, param_name)
      @args_1 = "/home/ykominami/repo/clitest/bin/cmd.sh /home/ykominami/repo/clitest/spec/test #{result} #{test_cmd_1} cmd1"
      @args_2 = "/home/ykominami/repo/clitest/bin/cmd.sh /home/ykominami/repo/clitest/spec/test #{result} #{test_cmd_2} cmd2"
    end

    it "of test_cmd_0" do
      expect(@ret_cmd_0).not_to eq(nil)
#      expect(@ret_cmd_0).not_to include("cmd.sh")
      expect(@ret_cmd_0).to include("cmd.sh")
    end
    it "of test_cmd_1" do
      expect(@ret_cmd_1).not_to eq(nil)
      expect(@ret_cmd_1).to include(@args_1)
    end
    it "of test_cmd_2" do
      expect(@ret_cmd_2).not_to eq(nil)
      expect(@ret_cmd_2).to include(@args_2)
    end
  end
end
