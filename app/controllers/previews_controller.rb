# -*- encoding: utf-8 -*-

class PreviewsController < ApplicationController
  before_action :ensure_authenticated!
  force_ssl

  def create
    render json: { body: send( params.require(:formater) ) }.to_json
  end

  private

    def markdown
      MarkdownService.call( params.require(:body) )
    end
end