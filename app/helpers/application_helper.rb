module ApplicationHelper

  def markdown(&block)
    raise ArgumentError, "Missing block" unless block_given?
    content = capture(&block)
    Tilt['markdown'].new { content }.render
  end

  class CategoryLinks

    def initialize(current_category, view_context)
      @current_category = current_category
      @view_context = view_context
    end

    def link_to(*args)
      @view_context.link_to_category(@current_category, *args)
    end

  end

  def current_user
    decorated_current_user
  end

  def page_title
    if content_for?(:title)
      "#{content_for(:title)} - asciinema".html_safe
    else
      "asciinema - Record and share your terminal sessions, the right way"
    end
  end

  def category_links(current_category, &blk)
    links = CategoryLinks.new(current_category, self)

    content_tag(:ul, class: 'nav nav-pills nav-stacked') do
      blk.call(links)
    end
  end

  def link_to_category(current_category, text, url, name)
    opts = {}

    if name == current_category
      opts[:class] = 'active'
    end

    content_tag(:li, link_to(text, url), opts)
  end

  def time_ago_tag(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(title: time.getutc.iso8601))
  end

  def default_user_theme_label(theme = Theme.default)
    "Default (#{theme.label})"
  end

  def default_asciicast_theme_label(theme)
    "Default account theme (#{theme.label})"
  end

  def themes_for_select
    Theme::AVAILABLE.invert
  end

  # 可按需修改
  LANGUAGES_LISTS = { "Ruby" => "ruby", "HTML / ERB" => "erb", "CSS / SCSS" => "scss", "JavaScript" => "js",
                      "YAML <i>(.yml)</i>" => "yml", "CoffeeScript" => "coffee", "Nginx / Redis <i>(.conf)</i>" => "conf",
                      "Python" => "python", "PHP" => "php", "Java" => "java", "Erlang" => "erlang", "Shell / Bash" => "shell" }

  def insert_code_menu_items_tag
    langs = []
    LANGUAGES_LISTS.each do |name, lng|
      langs << content_tag(:li) do
        content_tag(:a, raw(name), id: lng, class: 'insert_code', data: { content: lng })
      end
    end
    raw langs.join("")
  end

  def flash_notifications
    flash.select { |type, _| [:notice, :alert].include?(type.to_sym) }
  end

end
