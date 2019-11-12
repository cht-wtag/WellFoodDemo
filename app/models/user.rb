class User < ApplicationRecord
  include Clearance::User
  has_many :items
  has_many :meal_plans

  def item_options
  items.map do |item|
    [item.name, item.id]
  end
  end
end
