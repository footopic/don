# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  text       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_articles_on_title    (title)
#  index_articles_on_user_id  (user_id)
#

class Article < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [:publish, :limit, :wip], default: :limit

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :stars

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true

  scope :sorted_by_recently, -> { reorder('updated_at DESC') }
  scope :recently_edit, -> { reorder('updated_at DESC').take(5) }
  scope :recently_create, -> { reorder('created_at DESC').take(5) }
  scope :with_associations, -> { includes(:tags, :user, stars: :user) }

  acts_as_taggable

  paginates_per 20

  def to_date_str
    # TODO: use module
    return diff(updated_at, Time.current)
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

  # 最新の更新は新規投稿のみである？
  def only_created?
    # histories.size == 1
    updated_at == created_at
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

  def star_count_list
    stars      = self.stars.includes(:user)
    count_list = Hash.new(0)
    stars.map do |star|
      count_list[star.user] += 1
    end
    count_list.map { |user, c| { user: user, count: c } }
  end

  def add_star(user)
    stars.create(user_id: user.id)
  end
end
