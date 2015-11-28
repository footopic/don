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
:100: :abc:
:chicken: :sob:'''

30.times do |n|
  Article.seed do |s|
    s.user_id = 1
    s.title = "記事#{n}"
    s.text = dummy_text
  end
end

Article.seed do |s|
  s.user_id = 1
  s.title = '*@&#(!@^$<script>alert(\'\')</script>:smile:'
  s.text = '''*@&#(!@^$<script>alert(\'\')</script>:smile:'''
end

Article.seed do |s|
  s.user_id = 1
  s.title = 'カテゴリ1/タイトル #tag1 #tag2'
  s.text = '''本文'''
end

