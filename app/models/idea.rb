class Idea < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :content, presence: true

  def favorite?
    favorite_at != nil
  end
  
  def favorite
    self.favorite_at = Time.now
  end

  def favorite!
    favorite
    save!
  end

  def unfavorite
    self.favorite_at = nil
  end

  def unfavorite!
    unfavorite
    save!
  end
end
