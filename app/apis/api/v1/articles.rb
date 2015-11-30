module API
  module V1
    class Articles < Grape::API
      resource :articles do
        formatter :json, Grape::Formatter::Jbuilder

        # GET /api/articles
        desc 'Get articles'
        params do
          optional :tags, type: String, desc: 'Tags splited with ,(comma)'
        end
        get '/', jbuilder: 'article/index' do
          if params.tags
            tags = params.tags.split(',')
            @articles = Article.tagged_with(tags)
          end
        end
      end
    end
  end
end
