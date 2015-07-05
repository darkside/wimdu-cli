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
    attribute :nightly_rate, Type::Decimal
    attribute :max_guests,   Type::Integer
    attribute :email
    attribute :phone_number

    def validate!
      raise "Not Implemented yet"
    end

    protected

    def before_create
      assign_slug
    end

    def assign_slug
      self.slug = rand(36**8).to_s(36)
    end

  end
end
