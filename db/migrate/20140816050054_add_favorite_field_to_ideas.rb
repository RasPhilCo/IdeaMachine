class AddFavoriteFieldToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :favorite_at, :datetime
  end
end
