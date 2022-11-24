class ActualMoneyCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  attr_accessor :collection

  def initialize(money_places, attributes = [])
    if attributes.nil?
      if money_places.present?
        self.collection = money_places.map do |money_place|
          ActualMoney.new(user_id: money_place.user.id, money_place_id: money_place.id)
        end
      end
    else money_places.nil? && attributes.present?
      self.collection = attributes.map do |attribute|
        ActualMoney.new(
                    money_place_id: attribute['money_place_id'],
                    amount: attribute['amount']
                  )
      end
    end
  end
end