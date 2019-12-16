# frozen_string_literal: true

class RatingOrderedPostsQuery
  def initialize(limit)
    @limit = limit
  end

  def execute
    Post.where.not(average_rating: nil).order(average_rating: :desc).limit(@limit).select(:title, :body).map do |post|
      { title: post.title, body: post.body }
    end
  end
end
