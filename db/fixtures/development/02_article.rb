dummy_text = '' 'test
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
:100: :abc: :chicken: :sob:' ''

5.times do |n|
  Article.seed do |s|
    s.user_id = 2
    s.title   = "テンプレート#{n}"
    s.text    = "テンプレート#{n} の本文です\n---"
  end
  a = Article.last
  a.tag_list << 'template'
  a.tag_list << %w(hoge fuga).sample((0..2).to_a.sample)
  a.save
end

30.times do |n|
  Article.seed do |s|
    s.user_id = 1
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
    s.user_id = 1
    s.article_id = n + 1
  end
end

Article.seed do |s|
  s.user_id = 1
  s.title   = '*@&#(!@^$<script>alert(\'\')</script>:smile:'
  s.text    = '' '*@&#(!@^$<script>alert(\'\')</script>:smile:' ''
end

History.seed do |s|
  s.user_id = 1
  s.article_id = Article.last.id
end

Article.seed do |s|
  s.user_id = 1
  s.title   = 'カテゴリ1/タイトル #tag1 #tag2'
  s.text    = '' '本文' ''
end

Article.seed do |s|
  s.user_id = 2
  s.title   = 'コメント記事'
  s.text    = '' '↓コメント一覧' ''
end

History.seed do |s|
  s.user_id = 2
  s.article_id = Article.last.id
end


Article.seed do |s|
  s.user_id = 2
  s.title   = 'テンプレート変数 %{me} %{name}'
  s.text    = '''
%{Year}年%{month}月%{day}日
%{me}
'''
end
a = Article.last
a.tag_list << 'template'
a.tag_list << '週報%{cWeek}'
a.save
