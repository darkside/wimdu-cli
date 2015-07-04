require 'spec_helper'

RSpec.describe Wimdu::Property do
  describe "#create" do
    context "with valid attributes" do
      let(:attributes) { { type: "apartment" } }
      it "saves the record" do
        record = described_class.create attributes
        expect(record.new?).to eq false
      end
    end
  end
end
