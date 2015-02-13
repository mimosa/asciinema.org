# -*- encoding: utf-8 -*-
require 'singleton'
require 'rouge/plugins/redcarpet'

class MarkdownService
  class Renderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def initialize(extensions={})
      super(
        extensions.merge({
          filter_html: true,
          link_attributes: { rel: 'nofollow', target: '_blank' }
        })
      )
    end
  end

  class Template < Tilt::RedcarpetTemplate
    self.default_mime_type = 'text/x-markdown'

    def self.engine_initialized?
      defined? ::Redcarpet::Markdown and defined? ::Rouge::Plugins::Redcarpet
    end

    def prepare
      @output = nil
    end

    def evaluate(scope, locals, &block)
      @output ||= ::MarkdownService.call(data)
    end

    def allows_script?
      false
    end
  end

  include Singleton

  attr_reader :markdown

  def self.call(markdown)
    new(markdown).call
  end

  def initialize(markdown)
    @markdown = markdown
  end

  def call
    render
  end

  private

    def renderer
      Redcarpet::Markdown.new(Renderer, extensions)
    end

    def render
      # Rails.cache.fetch cache_key do
        renderer.render(markdown).html_safe
      # end
    end

    def cache_key
      sha ||= Digest::SHA1.hexdigest(markdown)
      ['markdown', sha].join('-')
    end
    
    def extensions
      {
        autolink: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        no_intra_emphasis:  true,
        strikethrough: true,
        superscript: true
      } 
    end
end