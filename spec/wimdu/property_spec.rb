require 'spec_helper'

RSpec.describe Wimdu::Property do
  describe "#create" do
    context "with valid attributes" do
      let(:attributes) { { type: "apartment" } }

      it "saves the record" do
        record = described_class.create attributes
        expect(record.new?).to eq false
      end

      it "assigns a slug" do
        record = described_class.create attributes
        expect(record.slug).to be_present
      end

      context "when all attributes are present" do
        let(:attributes) {
          {
            type: "apartment",
            title: "Some title",
            address: "Something",
            nightly_rate: 50.0,
            max_guests: 10,
            email: "example@example.com",
            phone_number: "12345678"
          }
        }
        it "assigns available = true" do
          record = described_class.create attributes
          expect(record.available).to eq true
        end
      end

    end
  end
end
