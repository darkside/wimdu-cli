module Wimdu
  module Commands
    class List < Base
      # @return[Array<Wimdu::Property>] the list of available properties
      attr_reader :properties

      def initialize
        @properties = Property.find(available: true)
      end

      # Shows a list of offers if there is at least one property available in
      # {#properties}, otherwise responds with 'No offers found.'
      # @return [List] itself
      def call
        if properties.size > 0
          say "Found #{properties.size} offer(s)"
          properties.each { |p| say "#{p.slug}: #{p.title}" }
        else
          say "No offers found."
        end
        self
      end

      # (see #call)
      def self.call
        new.call
      end
    end
  end
end
