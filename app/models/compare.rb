class Compare

  def self.template_variable(text)
    if text.is_a? Array
      text.map { |w| Compare.template_variable(w) }
    else
      val_regex = /%{(.*?)}/x
      text.gsub(val_regex) do |w|
        key = w[2..-2]
        c = Compare.compare_patterns
        if c.has_key? key
          c[key]
        else
          # w
          '____'
        end
      end
    end
  end

  def self.compare_patterns
    {
        'Year' => 2015,
        'month' => 12,
        'day' => 31,
        'cWeek' => 48,
        'me' => 'abcdefghijklm',
        'name' => '魔王'
    }
  end

end