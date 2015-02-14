# -*- encoding: utf-8 -*-

class PhotosController < ApplicationController
  before_action :ensure_authenticated!
  force_ssl
  before_action :local_imageable, only: :create

  def create

    photo = current_user.photos.new(image: create_params, imageable: @imageable, user_agent: request.user_agent, remote_ip: request.remote_ip)

    render text: photo.save ? photo.image_url(720) : photo.errors.full_messages.join("\n")
  end

  private
    def local_imageable
      if params[:imageable_type].present? 
        imageable_id = params["#{params[:imageable_type]}_id".singularize.to_sym]
        klass = params[:imageable_type].to_s.classify.safe_constantize
        # 找资源
        if klass && imageable_id.present?
          @imageable = klass.find(imageable_id) 
        end
      end
    end

    def create_params
      params.require(:Filedata)
    end
end