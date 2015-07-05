module Wimdu
  module Commands
    class Continue < Base
      attr_reader :slug, :property

      def initialize(slug)
        @slug     = slug
        @property = Wimdu::Property.find(slug: slug).first
      end

      def call
        # Check that we have a valid property
        if !!property
          say "Continuing with #{@slug}"
          ChangeProperty.call(@property)
          say "Property #{property.slug} was updated"
        else
          say("Error: Couldn't find property with slug #{@slug}")
        end
        self
      end

      def self.call(slug)
        new(slug).call
      end
    end
  end
end
