module API
  module V1
    class Templates < Grape::API
      resource :templates do
        formatter :json, Grape::Formatter::Jbuilder

        # GET /api/templates
        desc 'Get template articles'
        params do
          requires :me, type: String
          requires :name, type: String
        end
        get '/' do
          with = Entity::V1::TemplateArticleEntity
          compare = Compare.new({ 'me' => params.me, 'name' => params.name })
          articles = Article.tagged_with('template')
          articles = articles.each { |article| article.set_compare(compare) }
          present articles, with: with
        end
      end
    end
  end
end
