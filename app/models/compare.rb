class Compare

  def self.template_variable(text)
    if text.is_a? Array
      text.map { |w| Compare.template_variable(w) }
    else
      # TODO: create
      "#{text}"
    end
  end

end