class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_by_created_time, ->{order(created_at: :desc)}
  scope :user_owner, ->(user_id){where "user_id = ?", user_id}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content,
    presence: true,
    length: {maximum: Settings.maximum_content_length}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.max_image_size.megabytes
    errors.add :picture, :picture_size_notice, maximum: Settings.max_image_size
  end
end
