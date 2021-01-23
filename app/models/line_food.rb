class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  # 関連付け任意
  belongs_to :order, optional: true

  # 数値0以上
  validates :count, numericality{greater_than: 0}

  # LineFood.active.allでactive: trueを条件に引っ張ってくる
  scope :active, -> {where(active: true)}
  # restaurant_idが特定店舗IDでないものを一覧に返す
  # 引数を指定(picked_restaurant_id)
  scope :other_restaurant, -> { picked_restaurant_id } { where.not(restaurant_id: picked_restaurant_id) }

  def total_amount
    food.price * count
  end
end