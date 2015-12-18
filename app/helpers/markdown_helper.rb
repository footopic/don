module MarkdownHelper
  def markdown(text)
    unless @markdown
      renderer  = Redcarpet::Render::HTML.new(hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(
          renderer,
          tables: true,
          strikethrought: true,
          fenced_code_blocks: true,
          space_after_headers: true
      )
    end

    @markdown.render(text).html_safe
  end
end