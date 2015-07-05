module Wimdu
  module Commands
    # Abstract class inherited by all commands to extract common functionality.
    class Base
      delegate :ask, :say, to: :terminal

      # The terminal we use for interactive prompts
      # @return [HighLine] a HighLine instance
      def terminal
        @terminal ||= HighLine.new
      end
    end
  end
end
