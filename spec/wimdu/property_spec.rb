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
    end
  end
end
