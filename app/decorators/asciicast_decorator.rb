class AsciicastDecorator < ApplicationDecorator

  THUMBNAIL_WIDTH = 20
  THUMBNAIL_HEIGHT = 10

  decorates_association :user

  def os
    if user_agent.present?
      os_from_user_agent
    elsif uname.present?
      os_from_uname
    else
      'unknown'
    end
  end

  def terminal_type
    model.terminal_type.presence || '?'
  end

  def shell
    File.basename(model.shell.to_s)
  end

  def title
    model.title.presence || command || "asciicast:#{id}"
  end

  def command
    model.command != model.shell && model.command.presence
  end

  def thumbnail(width = THUMBNAIL_WIDTH, height = THUMBNAIL_HEIGHT)
    snapshot = Snapshot.build(model.snapshot || [[]] * height)
    thumbnail = SnapshotDecorator.new(snapshot.thumbnail(width, height))
    h.render 'asciicasts/thumbnail', :thumbnail => thumbnail
  end

  def body
    model.body.to_s if model.body.present?
  end

  def body_html
    model.body_html.html_safe if model.body_html.present?
  end

  def body_text
    h.strip_tags body_html if body_html.present?
  end

  def author_link
    user.link
  end

  def author_img_link
    user.img_link
  end

  def formatted_duration
    duration = model.duration.to_i
    minutes = duration / 60
    seconds = duration % 60

    "%02d:%02d" % [minutes, seconds]
  end

  def theme_name
    (model.theme || user.theme || Theme.default).name
  end

  private

    def os_from_user_agent
      os_part = user_agent.split(' ')[2]
      os = os_part.split('/').first

      guess_os(os)
    end

    def os_from_uname
      guess_os(uname)
    end

    def guess_os(text)
      if text =~ /Linux/i
        'Linux'
      elsif text =~ /Darwin/i
        'OS X'
      else
        text.split(/[\s-]/, 2)[0].to_s.titleize
      end
    end

end
