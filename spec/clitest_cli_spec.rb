require "spec_helper"
require "pathname"

RSpec.describe "command-line", type: :aruba do
  let(:bin_pn) { Pathname.new(__FILE__).parent.parent.join("bin") }
  let(:spec_dir_pn) { Pathname.new(__FILE__).parent }
  let(:spec_dir) { top_dir_pn.to_s }
  let(:top_dir_pn) { spec_dir_pn.parent }
  let(:top_dir) { top_dir_pn.to_s }
  let(:test_root_dir_pn) { spec_dir_pn.join("test") }
  let(:test_root_dir) { test_root_dir_pn.to_s }
  let(:bin_dir_pn) { top_dir_pn.join("bin") }
  let(:bin_dir) { bin_dir_pn.to_s }
  let(:test_cmd_1) { "ls" }
  let(:test_cmd_2) { "data" }
  let(:result) { "result.txt" }
  let(:optionx) { nil }
  let(:param_name) { nil }

  let(:cmdline_0) { Clitest::Cmdline.new(nil, nil, test_root_dir, test_cmd_1, test_cmd_2) }
  let(:cmdline_1) { Clitest::Cmdline.new(bin_dir, nil, test_root_dir, test_cmd_1, test_cmd_2) }

  it "has a version number" do
    expect(Clitest::VERSION).not_to be nil
  end

  it "has test_cmd" do
    expect(cmdline_0.test_cmd_path_pn.to_s).to include( bin_pn.join("clitest").to_s )
  end

  context "create instance of class" do
    context "Cmdline nil nil" do
      before(:each) do
        @cmdline = Clitest::Cmdline.new(nil, nil, test_root_dir, test_cmd_1, test_cmd_2)
      end
      it "create instance with nil and nil" do
        expect(@cmdline).not_to eq(nil)
        # expect(@cmdline).to eq(nil)
      end
    end

    context "Cmdline bin_dir nil" do
      before(:each) do
        @cmdline = Clitest::Cmdline.new(bin_dir, nil, test_root_dir, test_cmd_1, test_cmd_2)
      end
      it "create instance with bin dir and nil" do
        expect(@cmdline).not_to eq(nil)
        # expect(@cmdline).to eq(nil)
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
      cmd_path = bin_pn.join("clitest").to_s
      test_dir = bin_pn.parent.join("spec").join("test").to_s
      @args_1 = "#{cmd_path} #{test_dir} #{result} #{test_cmd_1} cmd1"
      @args_2 = "#{cmd_path} #{test_dir} #{result} #{test_cmd_2} cmd2"
    end

    it "of test_cmd_0" do
      expect(@ret_cmd_0).not_to eq(nil)
      # expect(@ret_cmd_0).not_to include("clitest")
      expect(@ret_cmd_0).to include("clitest")
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

