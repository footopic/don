# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string           default(""), not null
#  uid         :integer          not null
#  screen_name :string           default(""), not null
#  name        :string           default(""), not null
#

class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :omniauthable

  def is_owner(article)
    id == article.user_id
  end
end
