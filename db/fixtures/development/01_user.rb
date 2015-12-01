User.seed do |s|
  s.provider = 'esa'
  s.uid = 0
  s.screen_name = 'esa'
  s.name = 'esa.io'
end

User.seed do |s|
  s.provider = 'twitter'
  s.uid = 1106631758
  s.screen_name = 'elzup'
  s.name = 'えるざっぷ'
end

User.seed do |s|
  s.provider = 'twitter'
  s.uid = 2206303868
  s.screen_name = 'pear510'
  s.name = '梨原'
end
