# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  text          :text             not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string
#  lock          :boolean          default(FALSE)
#  type          :string
#  template_id   :integer
#  template_name :string
#
# Indexes
#
#  index_articles_on_title    (title)
#  index_articles_on_type     (type)
#  index_articles_on_user_id  (user_id)
#

class Template < Article
  validate :template_name
end
