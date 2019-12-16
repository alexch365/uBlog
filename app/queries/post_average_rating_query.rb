# frozen_string_literal: true

class PostAverageRatingQuery
  def initialize(post_id)
    @post_id = post_id
  end

  def execute
    Rating.where(post_id: @post_id).average(:value)&.to_f&.round(2) || 0
  end
end
