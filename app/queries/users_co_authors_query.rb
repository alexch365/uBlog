# frozen_string_literal: true

class UsersCoAuthorsQuery
  def self.execute
    query = Post.connection.execute <<-SQL.squish
      select author_ip, jsonb_agg(distinct users.login) as user_logins
      from posts
      inner join users on posts.user_id = users.id
      group by author_ip
      having count(*) > 2
    SQL

    query.to_a.each { |obj| obj['user_logins'] = JSON.parse(obj['user_logins']) }
  end
end
