user1 = User.first
user2 = User.find(2)

5.times do |n|
  Article.seed do |s|
    s.user_id       = user1.id
    s.title         = "記事#{n}"
    s.text          = "テンプレート#{n} の本文です\n---"
    s.status        = 'publish'
    s.type          = 'Template'
    s.template_name = "テンプレート#{n}"
    s.lock          = true
  end
  a = Article.last
  a.tag_list << %w(hoge fuga).sample((0..2).to_a.sample)
  a.save
end

Article.seed do |s|
  s.user_id       = user2.id
  s.title         = 'テンプレート変数 %{me} %{name}'
  s.type          = 'Template'
  s.template_name = 'テンプレート変数確認'
  s.text          = '''
| 変数     | val      |
|----------|----------|
| year     | %{year}  |
| Year     | %{Year}  |
| month    | %{month} |
| day      | %{day}   |
| week     | %{week}  |
| cDay     | %{cDay}  |
| cWeek    | %{cWeek} |
| me       | %{me}    |
| name     | %{name}  |
'''
end
a = Article.last
a.tag_list << 'template'
a.tag_list << '週報%{cWeek}'
a.save
