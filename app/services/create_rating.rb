# frozen_string_literal: true

class CreateRating
  include ActiveModel::Validations

  validates :value, numericality: { greater_than: 0, less_than: 6 }
  validates :post, presence: true

  attr_reader :value, :post, :rating

  def self.execute(params)
    service = new(params)
    return service if service.invalid?

    service.create
    PostUpdateAverageRatingQuery.new(service.post.id).execute
    service
  end

  def initialize(params)
    @value = params[:value]
    @post = Post.find_by(id: params[:post_id])
  end

  def create
    @rating = Rating.create(post_id: @post.id, value: @value)
  end
end
