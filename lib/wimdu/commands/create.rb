# Creates a new property and sends it to change property
module Wimdu
  module Commands
    class Create < Base
      attr_reader :property

      def initialize
        @property = Wimdu::Property.create
      end

      def call
        say "Starting with new property #{@property.slug}"

        ChangeProperty.call(@property)

        say "Property #{property.slug} was created."
      end

      def self.call
        new.call
      end
    end
  end
end
