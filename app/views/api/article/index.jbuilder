json.articles @articles do |article|
  json.(article, :id, :title, :text)
  json.set! :tags, article.tag_list
end
