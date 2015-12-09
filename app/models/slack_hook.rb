class SlackHook
  # TODO: configに移動
  BASE_URL = 'http://staging.don.cps.im.dendai.ac.jp'
  HOOK_URL = 'https://hooks.slack.com/services/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'

  def initialize
    @notifier = Slack::Notifier.new HOOK_URL
  end

  def post(article)
    article_url = File.join(BASE_URL, Rails.application.routes.url_helpers.article_path(article))
    icon_url    = File.join(BASE_URL, article.user.image_url)
    msg         = "#{article.user.screen_name}が[#{article.title}](#{article_url})を投稿しました"
    msg         = Slack::Notifier::LinkFormatter.format(msg)

    text = {
        text: article.text
    }

    unless Rails.env.development
      @notifier.ping msg, icon_url: icon_url, username: article.user.screen_name + '@丼', attachments: [text]
    end
  end
end
