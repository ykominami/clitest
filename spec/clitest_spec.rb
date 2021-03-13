# frozen_string_literal: true
require 'spec_helper'
require 'pathname'

RSpec.describe Clitest do
  let(:test_dir_pn){ Pathname.new(__FILE__).parent + 'test' }
  let(:test_dir){ test_dir_pn.to_s }
  let(:test_cmd_1){ 'test_cmd_1'}
  let(:test_cmd_2){ 'test_cmd_2'}
  let(:target_dir){ (test_dir_pn + 'cmd1').to_s }
  let(:result){'result.txt'}
  let(:optionx){nil}
  let(:param_name){nil}

  let(:cmdline0) { Clitest::Cmdline.new(test_dir, test_cmd_1, test_cmd_2) }
  it "has a version number" do
    expect(Clitest::VERSION).not_to be nil
  end

  context "create instance of class" do
    context "Cmdline" do
      before(:each)  do
        @cmdline = Clitest::Cmdline.new(test_dir)
      end
      it "create instance" do
        expect(@cmdline).not_to eq(nil)
      end
    end
  end

  context "make argument" do
    before(:each)  do
      @ret_cmd_1 = cmdline0.make_cmdline_1(target_dir, result, optionx, param_name)
      @ret_cmd_2 = cmdline0.make_cmdline_1(target_dir, result, optionx, param_name)
    end

    it "of test_cmd_1" do
      expect(@ret_cmd_1).not_to eq(nil)
    end
    it "of test_cmd_2" do
      expect(@ret_cmd_2).not_to eq(nil)
    end
  end
end
