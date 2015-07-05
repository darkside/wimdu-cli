# Changes a Property by getting inputs from the terminal.
module Wimdu
  module Commands
    class ChangeProperty < Base
      VALID_TYPES = ["holiday home", "apartment", "private_room"]
      attr_reader :property

      def initialize(property)
        @property = property
      end

      def self.call(property)
        new(property).call
      end

      def call
        ask_for_title
        ask_for_type
        ask_for_address
        ask_for_nightly_rate
        ask_for_max_guests
        ask_for_email
        ask_for_phone_number

        @property.save

        self
      end

      # Title
      def ask_for_title
        @property.title = ask("Title: ", String, &cant_be_blank)
        say "Okay, title is #{@property.title}."
      end

      # Type
      def ask_for_type
        @property.type = ask("Type: ") do |q|
          q.in = VALID_TYPES
          q.responses[:not_valid] = "Error: must be one of #{VALID_TYPES.join(', ')}"
        end
        say "Okay, type is #{@property.type}."
      end

      # Address
      def ask_for_address
        @property.address = ask("Address: ", String, &cant_be_blank)
        say "Okay, address is #{@property.address}."
      end

      # Nightly rate
      def ask_for_nightly_rate
        @property.nightly_rate = ask("Nightly rate (EUR): ", Float)
        say "Okay, nightly rate is #{@property.nightly_rate} EUR."
      end

      # Max Guests
      def ask_for_max_guests
        @property.max_guests = ask("Max guests: ", Integer)
        say "Okay, max guests is #{@property.max_guests}."
      end

      # Email
      def ask_for_email
        @property.email = ask("Email: ", String, &cant_be_blank)
        say "Okay, email is #{@property.email}."
      end

      # Phone Number
      def ask_for_phone_number
        @property.phone_number = ask("Phone number: ", String, &cant_be_blank)
        say "Okay, phone number is #{@property.phone_number}."
      end

      protected

      def cant_be_blank
        Proc.new do |question|
          question.validate = -> (a) { !a.blank? }
          question.responses[:not_valid] = "Error: can't be blank"
        end
      end

    end
  end
end
