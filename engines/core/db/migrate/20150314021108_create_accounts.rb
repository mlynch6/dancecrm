class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, null: false, limit: 100
      t.string :subdomain, null: false, limit: 50
      t.integer :owner_id

      t.timestamps null: false
    end
		add_index :accounts, :owner_id
  end
end
