class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  devise :omniauthable
  mount_uploader :image, ImageUploader

  def is_owner(article)
    id == article.user_id
  end
end
