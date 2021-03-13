# frozen_string_literal: true

RSpec.describe Clitest do
  it "has a version number" do
    expect(Clitest::VERSION).not_to be nil
  end

  context "create instance of class" do
    context "Cmdline" do
      before(:each)  do
        @cmdline = Cmdline.new
      end
      it "create instance" do
        expect(@cmdline).not_to eq(nil)
      end
    end
  end
end
