
module Wimdu
  module Commands
    # Fills in a Wimdu::Property by getting inputs from the terminal.
    class ChangeProperty < Base
      VALID_TYPES = ["holiday home", "apartment", "private_room"]

      # @return [Wimdu::Property] The property to work on.
      attr_reader :property

      # @param [Wimdu::Property] property
      def initialize(property)
        @property = property
      end

      # Instantiates an instance with a {Wimdu::Property} and calls #call on the
      # instance.
      # @param (see #call)
      # @return (see #call)
      def self.call(property)
        new(property).call
      end

      # Interactively prompts for {Wimdu::Property} attributes unless they are
      # already present in the given instance (which can happen if the user
      # cancelled this command previously and is using `wimdu continue :slug`
      # @return [ChangeProperty] itself
      def call
        ask_for_title        unless @property.title.present?
        ask_for_type         unless @property.type.present?
        ask_for_address      unless @property.address.present?
        ask_for_nightly_rate unless @property.nightly_rate.present?
        ask_for_max_guests   unless @property.max_guests.present?
        ask_for_email        unless @property.email.present?
        ask_for_phone_number unless @property.phone_number.present?
        self
      end

      # Interactively asks for the title attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_title
        property.title = ask("Title: ", String, &cant_be_blank)
        property.save
        say "Okay, title is #{@property.title}."
        self
      end

      # Interactively asks for the type attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_type
        property.type = ask("Type: ") do |q|
          q.in = VALID_TYPES
          q.responses[:not_valid] = "Error: must be one of #{VALID_TYPES.join(', ')}"
        end
        property.save
        say "Okay, type is #{@property.type}."
        self
      end

      # Interactively asks for the address attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_address
        property.address = ask("Address: ", String, &cant_be_blank)
        property.save
        say "Okay, address is #{@property.address}."
        self
      end

      # Interactively asks for the nightly rate attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_nightly_rate
        @property.nightly_rate = ask("Nightly rate (EUR): ", Float)
        @property.save
        say "Okay, nightly rate is #{@property.nightly_rate} EUR."
        self
      end

      # Interactively asks for the max guests attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_max_guests
        property.max_guests = ask("Max guests: ", Integer)
        property.save
        say "Okay, max guests is #{@property.max_guests}."
        self
      end

      # Interactively asks for the email attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_email
        property.email = ask("Email: ", String, &cant_be_blank)
        property.save
        say "Okay, email is #{@property.email}."
        self
      end

      # Interactively asks for the phone number attribute. Assigns valid response to
      # {#property} and saves the record.
      # @return [ChangeProperty]
      def ask_for_phone_number
        property.phone_number = ask("Phone number: ", String, &cant_be_blank)
        property.save
        say "Okay, phone number is #{@property.phone_number}."
        self
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
