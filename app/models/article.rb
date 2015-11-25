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
      return (d / 1.month).round.to_s + 'mo'
    elsif d >= 1.day
      return (d / 1.day).round.to_s + 'd'
    elsif d >= 1.hour
      return (d / 1.hour).round.to_s + 'h'
    elsif d >= 1.minute
      return (d / 1.minute).round.to_s + 'm'
    end
    (d / 1.seconds).round.to_s + 's'
  end
end
