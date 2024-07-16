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
  let(:test_cmd_first) { "ls" }
  let(:test_cmd_second) { "data" }
  let(:result) { "result.txt" }
  let(:optionx) { nil }
  let(:param_name) { nil }

  let(:cmdline_first) { Clitest::Cmdline.new(nil, nil, test_root_dir, [test_cmd_first, test_cmd_second]) }
  let(:cmdline_second) { Clitest::Cmdline.new(bin_dir, nil, test_root_dir, [test_cmd_first, test_cmd_second]) }

  it "has a version number" do
    expect(Clitest::VERSION).not_to be_nil
  end

  it "has test_cmd" do
    expect(cmdline_first.test_cmd_path_pn.to_s).to include(bin_pn.join("clitest").to_s)
  end

  context "with create instance of class" do
    context "when Cmdline nil nil" do
      let(:cmdline) { Clitest::Cmdline.new(nil, nil, test_root_dir, [test_cmd_first, test_cmd_second]) }

      it "create instance with nil and nil" do
        expect(cmdline).not_to be_nil
        # expect(@cmdline).to eq(nil)
      end
    end

    context "when Cmdline bin_dir nil" do
      let(:cmdline) { Clitest::Cmdline.new(bin_dir, nil, test_root_dir, [test_cmd_first, test_cmd_second]) }

      it "create instance with bin dir and nil" do
        expect(cmdline).not_to be_nil
        # expect(@cmdline).to eq(nil)
      end
    end
  end

  context "with make argument" do
    let(:target_1_dir) { "cmd1" }
    let(:target_2_dir) { "cmd2" }
    let(:ret_cmd_first) { cmdline_first.make_cmdline_base(test_cmd_first, target_1_dir, result, optionx, param_name) }
    let(:ret_cmd_second) { cmdline_first.make_cmdline_2(target_1_dir, result, optionx, param_name) }
    let(:ret_cmd_third) { cmdline_first.make_cmdline_2(target_2_dir, result, optionx, param_name) }
    let(:cmd_path) { bin_pn.join("clitest").to_s }
    let(:test_dir) { bin_pn.parent.join("spec").join("test").to_s }
    let(:args_first) { "#{cmd_path} #{test_dir} #{result}" }
    let(:args_second) { "#{cmd_path} #{test_dir} #{result} #{test_cmd_second}" }

    it "of test_cmd_0" do
      expect(ret_cmd_first).not_to be_nil
      # expect(@ret_cmd_first).not_to include("clitest")
      expect(ret_cmd_first).to include("clitest")
    end

    it "of test_cmd_first" do
      expect(ret_cmd_second).not_to be_nil
      expect(ret_cmd_second).to include(args_first)
    end

    it "of test_cmd_second" do
      expect(ret_cmd_third).not_to be_nil
      expect(ret_cmd_third).to include(args_second)
    end
  end
end
