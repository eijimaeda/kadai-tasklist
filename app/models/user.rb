class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
end
