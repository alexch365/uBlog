class PostSerializer
  def initialize(post)
    @post = post
  end

  def serialize_with_data
    {
      id: @post.id,
      title: @post.title,
      body: @post.body,
      login: @post.user.login,
      author_ip: @post.author_ip.to_s
    }
  end

  def serialize_with_rating
    {
      id: @post.id,
      rating: PostAverageRatingQuery.new(@post.id).execute
    }
  end
end
