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
          hard_wrap: true, 
          link_attributes: { rel: 'nofollow', target: '_blank' }
        })
      )
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
      renderer.render(markdown).html_safe
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