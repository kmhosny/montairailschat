class User < ApplicationRecord
  has_secure_password
  has_many :chat_histories

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
