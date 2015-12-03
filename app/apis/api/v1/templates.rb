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
        get '/', jbuilder: 'article/template' do
          Compare.compare_patterns({
            'me' => params.me,
            'name' => params.name
          })
          @articles = Article.tagged_with('template')
        end
      end
    end
  end
end
