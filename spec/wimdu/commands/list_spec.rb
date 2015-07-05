require 'spec_helper'

RSpec.describe Wimdu::Commands::List do

  include_context "mocked terminal"

  describe "Class Methods" do

    describe ".call" do
      it "initializes an instance calls #call" do
        instance = double call: true
        expect(described_class).to receive(:new).and_return(instance)
        expect(instance).to receive(:call)
        described_class.call
      end
    end

  end

  describe "Instance Methods" do

    let(:instance) { described_class.new }

    describe "#call" do

      context "when there are no properties" do
        it "responds with no offers found" do
          instance.call
          output.rewind
          expect(output.gets).to match "No offers found."
        end
      end

      context "when there are properties" do
        let!(:property) do
          Wimdu::Property.create type: "apartment", title: "Some title",
            address: "Something",
            nightly_rate: 50.0,
            max_guests: 10,
            email: "example@example.com",
            phone_number: "12345678"
        end

        it "displays the properties" do
          instance.call
          output.rewind
          expect(output.gets).to include "Found 1 offer(s)"
          expect(output.gets).to include "#{property.slug}: #{property.title}"
        end
      end

    end
  end
end
