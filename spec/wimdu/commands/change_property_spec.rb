require 'spec_helper'

RSpec.describe Wimdu::Commands::ChangeProperty do

  include_context "mocked terminal"

  describe "Class Methods" do
    describe ".call" do
      it "initializes an instance with the arguments and calls #call" do
        instance = double(call: true)
        property = double
        expect(described_class).to receive(:new).with(property).and_return(instance)
        expect(instance).to receive(:call)
        described_class.call(property)
      end
    end
  end

  describe "Instance Methods" do

    let(:property) { Wimdu::Property.create }
    let(:instance) { described_class.new(property) }

    describe "#call" do
      it "asks all the questions, saves the record and responds with itself" do
        expect(instance).to receive(:ask_for_title)
        expect(instance).to receive(:ask_for_type)
        expect(instance).to receive(:ask_for_address)
        expect(instance).to receive(:ask_for_nightly_rate)
        expect(instance).to receive(:ask_for_max_guests)
        expect(instance).to receive(:ask_for_email)
        expect(instance).to receive(:ask_for_phone_number)
        response = instance.call
        expect(response).to eq instance
      end

      context "with some attributes filled in" do

        let(:property) do
          Wimdu::Property.create title: "My title", type: "apartment",
            address: "some address"
        end

        it "doesn't try to ask them again" do
          expect(instance).to_not receive(:ask_for_title)
          expect(instance).to_not receive(:ask_for_type)
          expect(instance).to_not receive(:ask_for_address)
          expect(instance).to receive(:ask_for_nightly_rate)
          expect(instance).to receive(:ask_for_max_guests)
          expect(instance).to receive(:ask_for_email)
          expect(instance).to receive(:ask_for_phone_number)
          instance.call
        end
      end
    end

    # TODO: Test validations, for some reason HighLine keeps breaking strangely
    # when it's not happy with the answer.
    describe "ask_for methods" do
      before do |example|
        input << response << "\n"
        input.rewind

        instance.send(example.metadata[:example_group][:description].gsub("#",''))

        output.rewind
      end

      describe "#ask_for_title" do
        let(:response) { "My amazing place" }
        it "responds with the title" do
          expect(output.gets).to match "Okay, title is #{response}"
        end
      end

      describe "#ask_for_type" do
        let(:response) { described_class::VALID_TYPES.first }
        it "responds with the type" do
          expect(output.gets).to match "Okay, type is #{response}"
        end
      end

      describe "#ask_for_address" do
        let(:response) { "My amazing address" }
        it "responds with the address" do
          expect(output.gets).to match "Okay, address is #{response}"
        end
      end

      describe "#ask_for_nightly_rate" do
        let(:response) { "25.50" }
        it "responds with the nightly rate" do
          expect(output.gets).to match "Okay, nightly rate is #{response.to_f} EUR"
        end
      end

      describe "#ask_for_max_guests" do
        let(:response) { "2" }
        it "responds with the max guests" do
          expect(output.gets).to match "Okay, max guests is #{response}"
        end
      end

      describe "#ask_for_email" do
        let(:response) { "foo@example.com" }
        it "responds with the email" do
          expect(output.gets).to match "Okay, email is #{response}"
        end
      end

      describe "#ask_for_phone_number" do
        let(:response) { "55 11 1234 5678" }
        it "responds with the phone number" do
          expect(output.gets).to match "Okay, phone number is #{response}"
        end
      end
    end

  end



end
