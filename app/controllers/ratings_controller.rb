# frozen_string_literal: true

class RatingsController < ApplicationController
  def create
    service = CreateRating.execute(rating_params)

    if service.errors.present?
      render json: service.errors.messages, status: 422
    else
      render json: PostSerializer.new(service.post).serialize_with_rating
    end
  end

  protected

  def rating_params
    params.require(:rating).permit(:value, :post_id)
  end
end
