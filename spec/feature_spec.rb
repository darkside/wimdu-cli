require "spec_helper"

RSpec.describe "Wimdu CLI" do
  let(:exe) { File.expand_path('../../bin/wimdu', __FILE__) }

  describe "new" do
    let(:cmd)     { "#{exe} new"        }
    let(:process) { CliProcess.new(cmd) }

    it "calls the right command" do
      expect(process).to have_output("Starting with new property")
      process.kill
      process.wait
    end
  end

  describe "continue" do
    let(:code)    { Wimdu::Property.create.slug }
    let(:cmd)     { "#{exe} continue #{code}"   }
    let(:process) { CliProcess.new(cmd)         }

    it "calls the right command" do
      expect(process).to have_output("Continuing with #{code}")
      process.kill
      process.wait
    end
  end

  describe "list" do
    let(:cmd)     { "#{exe} list"       }
    let(:process) { CliProcess.new(cmd) }

    it "calls the right command" do
      expect(process).to have_output("No offers found")
      process.kill
      process.wait
    end
  end
end
