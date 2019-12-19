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
  validate :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "アップロードできるファイルサイズは5MB以下です。")
      end
    end
end
