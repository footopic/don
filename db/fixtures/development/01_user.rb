User.seed do |s|
  s.provider = 'twitter'
  s.uid = 1106631758
  s.screen_name = 'elzup'
  s.name = 'えるざっぷ'
end
u = User.last
u.save_icon(File.open(Rails.root.join('import', 'images', 'elzup_icon.png')))

User.seed do |s|
  s.provider = 'twitter'
  s.uid = 2206303868
  s.screen_name = 'pear510'
  s.name = '梨原'
end
u = User.last
u.save_icon(File.open(Rails.root.join('import', 'images', 'pear510_icon.png')))

