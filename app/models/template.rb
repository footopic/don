# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  title      :string           not null
#  text       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_title    (title)
#  index_templates_on_user_id  (user_id)
#

class Template < ActiveRecord::Base
  extend Enumerize

  belongs_to :user

  validates :title, presence: true
  validates :text, presence: true
  validates :name, presence: true
  validates :user, presence: true

  acts_as_taggable

  paginates_per 20

  scope :sorted_by_recently, -> { reorder('updated_at DESC') }
  scope :with_associations, -> { includes(:tags, :user) }

  def unlock?
    true
  end

  def written_by?(user)
    user == self.user
  end

  def to_date_str
    # TODO: use module
    return diff(updated_at, Time.current)
  end

  # 最新の更新は新規投稿のみである？
  def only_created?
    # histories.size == 1
    updated_at == created_at
  end

  def diff(src, dist)
    d = dist - src

    if d >= 1.month
      (d / 1.month).round.to_s + 'mo'
    elsif d >= 1.day
      (d / 1.day).round.to_s + 'd'
    elsif d >= 1.hour
      (d / 1.hour).round.to_s + 'h'
    elsif d >= 1.minute
      (d / 1.minute).round.to_s + 'm'
    else
      (d / 1.seconds).round.to_s + 's'
    end
  end

  # TODO: template STL
  def set_compare(compare)
    @compare = compare
  end

  # variable を変換して返す
  def title_vr
    @compare.template_variable(title)
  end

  def text_vr
    @compare.template_variable(text)
  end

  def tag_list_vr
    @compare.template_variable(tag_list)
  end
end
