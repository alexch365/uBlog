# frozen_string_literal: true

class PostUpdateAverageRatingQuery
  def initialize(post_id)
    @post_id = post_id
  end

  def execute
    Post.transaction do
      Post.connection.execute <<-SQL.squish
        UPDATE posts
        SET average_rating = (
          SELECT COALESCE(AVG(value), 0)
          FROM ratings
          WHERE ratings.post_id = #{@post_id}
        )
        WHERE posts.id = #{@post_id}
      SQL
    end
  end
end

