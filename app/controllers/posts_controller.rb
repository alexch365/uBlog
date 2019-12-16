# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    service = CreatePost.execute(post_params)

    if service.errors.present?
      render json: service.errors.messages, status: 422
    else
      render json: PostSerializer.new(service.post).serialize_with_data
    end
  end

  def top
    render json: RatingOrderedPostsQuery.new(params[:limit] || 10).execute
  end

  protected

  def post_params
    params.require(:post).permit(:title, :content, :author_ip, :author_login).tap do |param|
      param[:author_ip] ||= request.remote_ip
    end
  end
end
