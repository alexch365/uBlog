class AddAverageRatingToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :average_rating, :numeric
  end
end
