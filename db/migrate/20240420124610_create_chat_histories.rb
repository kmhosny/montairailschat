class CreateChatHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_histories do |t|
      t.text :message, null: false
      t.integer :message_type, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
