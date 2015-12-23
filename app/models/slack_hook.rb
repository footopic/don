class SlackHook
  # TODO: configに移動
  BASE_URL = 'http://staging.don.cps.im.dendai.ac.jp'
  HOOK_URL = 'https://hooks.slack.com/services/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'

  def initialize
    @notifier = Slack::Notifier.new HOOK_URL
  end

  def img_url(text)
    if /(https?:\/\/.+?(jpg|png|gif|jpeg))/=~ text
      $1
    else
      nil
    end
  end

  def post(user, msg, text)
    icon_url = File.join(BASE_URL, user.image.url)

    attachments = [
        {
            text: text,
            image_url: img_url(text)
        }
    ]

    if Rails.env == 'production'
      @notifier.ping msg, icon_url: icon_url, username: user.screen_name + '@丼', attachments: attachments
    end
  end
end

