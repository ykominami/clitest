# frozen_string_literal: true
require 'spec_helper'
require 'pathname'

RSpec.describe 'command-line', type: :aruba do
  let(:test_dir_pn){ Pathname.new(__FILE__).parent + 'test' }
  let(:test_dir){ test_dir_pn.to_s }
  let(:test_cmd_1){ 'ls'}
  let(:test_cmd_2){ 'date'}
  let(:target_dir){ 'cmd1' }
  let(:result){'result.txt'}
  let(:optionx){nil}
  let(:param_name){nil}

  let(:cmdline0) { Clitest::Cmdline.new(test_dir, test_cmd_1, test_cmd_2) }

  context "exec" do
    context "test_cmd_1" do
      before(:each)  {
        cmdline = cmdline0.make_cmdline_1(target_dir, result, optionx, param_name)
        run_command("bash #{cmdline}")
      }

      it '', test_normal_sh:true do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true do expect(last_command_started).not_to have_output(/error:/) end
#      it '', test_normal_sh_out:true do expect(last_command_started).to have_output(/error:/) end
    end

    context "test_cmd_2" do
      before(:each)  {
        cmdline = cmdline0.make_cmdline_2(target_dir, result, optionx, param_name)
        run_command("bash #{cmdline}")
      }

      it '', test_normal_sh:true do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end