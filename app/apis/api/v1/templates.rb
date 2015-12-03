module API
  module V1
    class Templates < Grape::API
      resource :templates do
        formatter :json, Grape::Formatter::Jbuilder

        # GET /api/templates
        desc 'Get template articles'
        params do
        end
        get '/', jbuilder: 'article/template' do
          @articles = Article.tagged_with('template')
        end
      end
    end
  end
end
