# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  price       :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :product_categories, allow_destroy: true

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :main, resize_and_pad: [340, 340]
  end
end
