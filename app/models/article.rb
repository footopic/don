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

  def to_date_str
    # TODO: use module
    return self.diff(self.updated_at, Time.now)
  end

  def diff(src, dist)
    d = dist - src
    p d
    p d / 1.day
    p d / 1.hour
    p d / 1.minute

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
end
