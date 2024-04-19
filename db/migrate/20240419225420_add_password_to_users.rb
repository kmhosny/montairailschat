class AddPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string, null: false
    change_column :users, :email, :string, null: false
  end
end
