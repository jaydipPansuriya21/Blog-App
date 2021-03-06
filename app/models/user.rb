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

  has_many :relationships, foreign_key: "follower_id" , class_name:  "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed


  has_many :reverse_relationships, foreign_key: "followed_id" , class_name:  "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower





  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end



end
