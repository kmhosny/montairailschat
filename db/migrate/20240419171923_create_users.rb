class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end