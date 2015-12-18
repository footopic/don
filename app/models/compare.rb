class Compare

  def initialize(user)
    now = Time.current
    @compare_patterns = {
        'Year'  => now.strftime('%Y'),
        'year'  => now.strftime('%y'),
        'month' => now.strftime('%m'),
        'day'   => now.strftime('%d'),
        'week'  => now.strftime('%a'),
        'cDay'  => now.strftime('%j'),
        'cWeek' => now.strftime('%V'),
        'me'    => user.screen_name,
        'name'  => user.name
    }
  end

  def template_variable(text)
    if text.is_a? Array
      text.map { |w| template_variable(w) }
    else
      val_regex = /%{(.*?)}/x
      text.gsub(val_regex) do |w|
        key = w[2..-2]
        c   = @compare_patterns
        if c.has_key? key
          c[key]
        else
          w
        end
      end
    end
  end
end
