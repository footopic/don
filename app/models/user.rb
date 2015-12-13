# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string           default(""), not null
#  uid         :string           not null
#  screen_name :string           default(""), not null
#  name        :string           default(""), not null
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_screen_name       (screen_name) UNIQUE
#

class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :stars, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :provider, presence: true
  validates :uid, presence: true
  validates :screen_name, presence: true
  validates :name, presence: true

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def owner?(article)
    id == article.user_id
  end

  def image_url
    image.url || 'noimg.png'
  end

  def equal_id?(user)
    id.equal? user.id
  end


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(uid: data['uid'], provider: data['provider']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
          provider: data['provider'],
          uid:      data['uid'],
          name:     data['name']
      )
    end
    user
  end

  def save_icon(file)
    image.store!(file)
    save
  end
end
