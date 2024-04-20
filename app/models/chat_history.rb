class ChatHistory < ApplicationRecord
    belongs_to :user

    enum message_type: { request: 0, response: 1 }
  
    validates :message, presence: true
    validates :message_type, presence: true
    validates :user_id, presence: true
end
