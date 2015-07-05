module Wimdu
  module Commands
    # Creates a new property and fill it in.
    class Create < Base
      # @return [Wimdu::Property] The newly created property
      attr_reader :property

      # Creates a new {Wimdu::Property}
      def initialize
        @property = Wimdu::Property.create
      end

      # Sends the created {#property} to the {ChangeProperty} command.
      # @return [Create] itself
      def call
        say "Starting with new property #{property.slug}"

        ChangeProperty.call(property)

        say "Property #{property.slug} was created."

        self
      end

      # (see #call)
      def self.call
        new.call
      end
    end
  end
end
