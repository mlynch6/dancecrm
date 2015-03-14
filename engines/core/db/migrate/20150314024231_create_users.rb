class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :account_id, null: false
      t.string :email, null: false, limit: 50
      t.string :password_digest, null: false

      t.timestamps null: false
    end
		add_index :users, :account_id
  end
end
