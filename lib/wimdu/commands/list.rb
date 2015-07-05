module Wimdu
  module Commands
    class List < Base
      attr_reader :properties

      def initialize
        @properties = Property.find(available: true)
      end

      def call
        if properties.size > 0
          say "Found #{properties.size} offer(s)"
          properties.each { |p| say "#{p.slug}: #{p.title}" }
        else
          say "No offers found."
        end
        self
      end

      def self.call
        new.call
      end
    end
  end
end
