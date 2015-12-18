module Entity
  module V1
    class TemplateArticleEntity < BaseEntity
      expose :title do |article| article.title_vr end
      expose :text do |article| article.text_vr end
      expose :user, using: UserEntity
      expose :tags do |article|
        article.tags_vr - ['template']
      end
    end
  end
end
