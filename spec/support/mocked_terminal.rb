shared_context "mocked terminal" do
  let(:input)  { StringIO.new }
  let(:output) { StringIO.new }
  before do
    allow_any_instance_of(Wimdu::Commands::Base).to receive(:terminal) { HighLine.new(input, output) }
  end
end
