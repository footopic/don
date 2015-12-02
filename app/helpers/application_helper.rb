module ApplicationHelper
  def alert_class_for(flash_type)
    {
        :success => 'alert-success',
        :error   => 'alert-danger',
        :alert   => 'alert-warning',
        :notice  => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def tags_list_for(tags)
    content_tag :ul, class: 'tag_list' do
      tags.each do |tag|
        concat content_tag(:li, content_tag(:span, tag.name))
      end
    end
  end

  # def link_tags_list_for(tags)
  #   content_tag :ul, class: 'tag_list' do
  #     tags.each do |tag|
  #       concat content_tag(:li) do
  #         concat content_tag(:a, tag.name, 'hoge')
  #       end
  #     end
  #   end
  # end
end
