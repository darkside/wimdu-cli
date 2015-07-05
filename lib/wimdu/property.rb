# * Every property has the following attributes
#   * title
#   * property type, which is one of
#     * holiday home
#     * apartment
#     * private room
#   * address
#   * nightly rate in EUR
#   * max guests
#   * email
#   * phone number
module Wimdu
  class Property < Ohm::Model
    include Ohm::DataTypes
    include Ohm::Callbacks

    attribute :type
    attribute :title
    attribute :slug
    attribute :address
    attribute :nightly_rate
    attribute :max_guests
    attribute :available,    Type::Boolean
    attribute :email
    attribute :phone_number

    index :slug
    index :available

    protected

    def before_create
      assign_slug
    end

    def before_save
      assign_availability
    end

    def assign_slug
      self.slug = rand(36**8).to_s(36)
    end

    def assign_availability
      self.available = [:type, :title, :slug, :address, :nightly_rate, :max_guests, :email,
      :phone_number].all? do |attribute|
        self.send(attribute).present?
      end
    end

  end
end
