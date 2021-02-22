class User < ApplicationRecord

  before_save { self.email = email.downcase }

  has_many :microposts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  before_save :create_remember_token

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end



end
