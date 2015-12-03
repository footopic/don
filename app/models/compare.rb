class Compare

  def self.template_variable(text)
    if text.is_a? Array
      text.map { |w| Compare.template_variable(w) }
    else
      val_regex = /%{(.*?)}/x
      text.gsub(val_regex) do |w|
        key = w[2..-2]
        c = Compare.compare_patterns()
        if c.has_key? key
          c[key]
        else
          w
        end
      end
    end
  end

  def self.compare_patterns(options=nil)
    now = Time.now
    @@compare_patterns ||= {
        'Year' => now.strftime('%Y'),
        'year' => now.strftime('%y'),
        'month' => now.strftime('%m'),
        'day' => now.strftime('%d'),
        'cWeek' => now.strftime('%W'),
        'week' => now.strftime('%w'),
        'cDay' => now.strftime('%j')
    }.merge(options)
  end

end