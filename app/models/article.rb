# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  text       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

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

  def categories_text
    @categories_text ||= categories.join('/')
  end

  def categories
    @categories ||= names[0...(names.length - 1)]
  end

  def names
    @names ||= title.split('/')
  end

  def main_title
    @main_title ||= names[-1]
  end
end
