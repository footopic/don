# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stars_on_article_id  (article_id)
#  index_stars_on_user_id     (user_id)
#

class Star < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
end
