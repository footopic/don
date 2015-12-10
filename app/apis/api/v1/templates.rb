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
          Compare.compare_patterns({
                                       'me' => params.me,
                                       'name' => params.name
                                   })
          present Article.tagged_with('template'), with: with
        end
      end
    end
  end
end
