require 'spec_helper'

RSpec.describe Wimdu::Commands::Create do

  include_context "mocked terminal"

  describe "Class Methods" do
    describe ".call" do
      it "initializes an instance and calls #call" do
        instance = double(call: true)
        expect(described_class).to receive(:new).and_return(instance)
        expect(instance).to receive(:call)
        described_class.call
      end
    end
  end

  describe "Instance Methods" do

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

  end # / Instance Methods

end
