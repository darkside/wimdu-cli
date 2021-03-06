require 'spec_helper'

RSpec.describe Wimdu::Commands::Continue do

  include_context "mocked terminal"

  describe "Class Methods" do
    describe ".call" do
      it "initializes an instance with the arguments and calls #call" do
        instance = double(call: true)
        expect(described_class).to receive(:new).with("foo").and_return(instance)
        expect(instance).to receive(:call)
        described_class.call("foo")
      end
    end
  end

  describe "Instance Methods" do
    let(:instance) { described_class.new(slug) }

    describe "#call" do
      context "with a valid property" do
        let(:property) { Wimdu::Property.create }
        let(:slug)     {  property.slug         }

        before do
          allow(Wimdu::Property).to receive(:find).and_return([property])
        end

        it "calls ChangeProperty with the found property" do
          expect(Wimdu::Commands::ChangeProperty).to receive(:call).with(property)
          instance.call
        end

        it "responds with a success message" do
          allow(Wimdu::Commands::ChangeProperty).to receive(:call).and_return(true)
          instance.call
          output.rewind
          expect(output.gets).to match "Continuing with #{slug}"
          expect(output.gets).to match "Property #{slug} was updated"
        end
      end

      context "with no property" do
        let(:slug) { "foo" }
        it "doesn't call ChangeProperty" do
          expect(Wimdu::Commands::ChangeProperty).not_to receive(:call)
          instance.call
        end

        it "responds with an error message" do
          instance.call
          output.rewind
          expect(output.gets).to match "Error: Couldn't find property with slug #{slug}"
        end
      end

    end # / #call

  end # / Instance Methods

end
