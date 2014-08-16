class AddPasswordResetTimestampToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token_at, :datetime
  end
end
