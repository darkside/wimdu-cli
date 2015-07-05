require 'spec_helper'

RSpec.describe Wimdu::Commands::Create do

  describe "#initialize" do
    it "creates a new property" do
      expect(Wimdu::Property).to receive(:create).once
      instance = described_class.new
    end

    it "assigns a Wimdu::Property to #property" do
      instance = described_class.new
      expect(instance.property).to be_a Wimdu::Property
    end
  end

  describe "#call" do
    let(:instance) { described_class.new }
    it "calls ChangeProperty with the created property" do
      expect(Wimdu::Commands::ChangeProperty).to receive(:call).with(instance.property)
      instance.call
    end
  end

end
