module Wimdu
  module Commands
    # Continue a previously started offer.
    class Continue < Base
      # @return [String] a {#property} slug
      attr_reader :slug

      # @return [Wimdu::Property] The found property instance or nil
      attr_reader :property

      # Initializes the command by trying to find a {#property} associated with
      # the given slug.
      # @param [String] slug
      #   The slug to find the {Wimdu::Property} by
      def initialize(slug)
        @slug     = slug
        @property = Wimdu::Property.find(slug: slug).first
      end

      # If the slug was valid, starts a {ChangeProperty} command with the found
      # {#property}, otherwise displays an error message that the slug is invalid
      # @return [Continue]
      def call
        # Check that we have a valid property
        if !!property
          say "Continuing with #{@slug}"
          ChangeProperty.call(@property)
          say "Property #{property.slug} was updated"
        else
          say "Error: Couldn't find property with slug #{@slug}"
        end
        self
      end

      # Instantiates a new instance and calls {#call}.
      # @param (see #call)
      # @return (see #call)
      def self.call(slug)
        new(slug).call
      end
    end
  end
end
