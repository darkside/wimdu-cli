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
    attribute :address
    attribute :nightly_rate, Type::Decimal
    attribute :max_guests,   Type::Integer
    attribute :email
    attribute :phone_number

    def validate!
      raise "Not Implemented yet"
    end
  end
end
