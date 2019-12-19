class Seedlingspost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :item, presence: true
  validates :product_regulation, presence: true
  validates :scion, presence: true
  validates :rootstock, presence: true
  validates :count, presence: true
  validates :location, presence: true
  validates :order_unit, presence: true
end
