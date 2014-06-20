class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-z0-9]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }
end
