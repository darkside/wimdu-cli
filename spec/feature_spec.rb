require "spec_helper"

RSpec.describe "Wimdu CLI" do
  let(:exe) { File.expand_path('../../bin/wimdu', __FILE__) }

  describe "new" do
    let(:cmd) { "#{exe} new" }
    let(:process) { CliProcess.new(cmd) }

    it "allows for entering data" do
      expect(process).to have_output("Starting with new property")
      expect(process).to have_output("Title: ")
      process.type "My Title"
      expect(process).to have_output("Address: ")

      # FIXME: Please extend!

      process.kill
      process.wait
    end
  end

  describe "continue" do
    it "allows for resuming data entry" do
      code = nil

      CliProcess.new("#{exe} new").tap do |p|
        expect(p).to have_output("Title: ")
        p.type("My Title")
        code = p.output[/Starting with new property ([A-Z1-9]+)\./, 1]

        p.kill("INT")
        p.wait
      end

      CliProcess.new("#{exe} continue #{code}").tap do |p|
        expect(p).to have_output("Continuing with property #{code}")
        # FIXME: Please extend!
      end
    end
  end
end
