module Wimdu
  module Commands
    class Base
      delegate :ask, :say, to: :terminal
      def terminal
        @terminal ||= HighLine.new
      end
    end
  end
end
