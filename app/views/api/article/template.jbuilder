json.articles @articles do |article|
  json.(article, :id)
  json.set! :title, article.title_vr
  json.set! :text, article.text_vr
  tags = article.tag_list_vr
  tags.delete('template')
  json.set! :tags, tags
end
