article = Article.where(user_id: 2, title: 'コメント記事').first
10.times do
  Comment.seed do |s|
    s.article_id = article.id
    s.user_id = [1, 2].sample
    s.text = 'hoge だよね' * (1..10).to_a.sample
  end
end
