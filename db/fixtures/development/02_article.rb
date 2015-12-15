dummy_text = '''test
===

## マークダウン
リスト
* hoge
* fuga
* piyo

```rb
# markdown?
a = :hoge
b = 1092
test.fuga({ hoge: :fuga })
```

## 改行
1

2


3




5

## 絵文字 :+1:
:100: :abc: :chicken: :sob:'''

user1 = User.first
user2 = User.find(2)

5.times do |n|
  Article.seed do |s|
    s.user_id = user1.id
    s.title   = "テンプレート#{n}"
    s.text    = "テンプレート#{n} の本文です\n---"
    s.status   = 'publish'
    s.lock    = true
  end
  a = Article.last
  a.tag_list << 'template'
  a.tag_list << %w(hoge fuga).sample((0..2).to_a.sample)
  a.save
end

30.times do |n|
  Article.seed do |s|
    s.user_id = user1.id
    s.title   = "記事#{n}"
    s.text    = dummy_text
  end
  a = Article.last
  if n % 2 == 0
    a.tag_list << '日報'
  else
    a.tag_list << 'にっぽっぽー'
  end
  a.tag_list << %w(a b c).sample((0..3).to_a.sample)
  a.save
  History.seed do |s|
    s.user_id    = user1.id
    s.article_id = n + 1
  end
end

Article.seed do |s|
  s.user_id = user1.id
  s.title   = '*@&#(!@^$<script>alert(\'\')</script>:smile:'
  s.text    = '''*@&#(!@^$<script>alert(\'\')</script>:smile:'''
end

History.seed do |s|
  s.user_id    = user1.id
  s.article_id = Article.last.id
end

Article.seed do |s|
  s.user_id = user1.id
  s.title   = 'カテゴリ1/タイトル #tag1 #tag2'
  s.text    = '''本文'''
  s.lock    = true
end

Article.seed do |s|
  s.user_id = user2.id
  s.title   = 'コメント記事'
  s.text    = '''↓コメント一覧'''
end

History.seed do |s|
  s.user_id    = user2.id
  s.article_id = Article.last.id
end


Article.seed do |s|
  s.user_id = user2.id
  s.title   = 'テンプレート変数 %{me} %{name}'
  s.text    = '''
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

Article.seed do |s|
  s.user_id = user2.id
  s.title   = 'お気に入り記事'
  s.text    = '''不思議な力でお気に入りがたくさんつく記事です'''
end
a = Article.last
# user1: 6fav, user2: 5fav
11.times do |n|
  a.add_star([user1, user2][n % 2])
end

Article.seed do |s|
  s.user_id = user2.id
  s.title   = '編集履歴記事'
  s.text    = '''がんがん編集てしまう〜'''
  s.status   = 'publish'
  s.lock    = true
end
a = Article.last
# user1: 6fav, user2: 5fav
11.times do |n|
  a.add_star([user1, user2][n % 2])
end

Article.seed do |s|
  s.user_id = user2.id
  s.title   = 'ロックされてる他人の記事(タグ付き)'
  s.text    = '''タグ編集させないぞ'''
  s.status   = 'publish'
  s.lock    = true
end
a = Article.last
a.tag_list << 'hoge'
a.tag_list << 'fuga'
# user1: 6fav, user2: 5fav
11.times do |n|
  a.add_star([user1, user2][n % 2])
end
a.save
