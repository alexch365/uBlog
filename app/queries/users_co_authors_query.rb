# frozen_string_literal: true

class UsersCoAuthorsQuery
  def self.execute
    query = Post.connection.select_all <<-SQL.squish
      select distinct users.login, author_ip
      from posts
      inner join users on posts.user_id = users.id
    SQL

    result = {}
    query.rows.each do |row|
      result[row[1]] ||= []
      result[row[1]] |= [row[0]]
    end
    result.select { |_, v| v.length > 1 }
  end
end
