# -*- encoding: utf-8 -*-
 
module ActionView::Template::Handlers
  class Markdown
 
    class_attribute :default_format
    self.default_format = Mime::HTML
 
    def erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end
    
    def call(template)
      # sha ||= Digest::SHA1.hexdigest(template.source)
      # Rails.cache.fetch ['markdown', sha].join('-') do
        compiled_source = erb_handler.call(template)
        "MarkdownService.call(begin;#{compiled_source};end).html_safe"
      # end
    end
 
  end
end

Rails.application.config.before_initialize do
  Tilt.register MarkdownService::Template, 'markdown', 'mkd', 'md'

  [:md, :mkd, :markdown].each do |ext|
    ActionView::Template.register_template_handler ext, ActionView::Template::Handlers::Markdown.new
  end
end