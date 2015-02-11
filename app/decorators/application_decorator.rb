# -*- encoding: utf-8 -*-
class ApplicationDecorator < Draper::Decorator

  delegate_all

  def markdown(text)
    MarkdownService.call(text)
  end

end
