class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meals, -> {order(:date)}, inverse_of: :meal_plan, dependent: :destroy
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user, presence: true
 accepts_nested_attributes_for :meals
  def build_meals
    user_items_ids=user.items.pluck(:id)

    (start_date..end_date).each do |date|
      unused_item_ids=user_items_ids-meals.map(&:item_id)
      if unused_item_ids.empty?
        available_item_ids=user_items_ids
      else
        available_item_ids=unused_item_ids
      end
      meals.build(date: date, item_id: available_item_ids.sample)
    end
  end
  def to_s
    "#{start_date}   -   #{end_date}"
  end
end
