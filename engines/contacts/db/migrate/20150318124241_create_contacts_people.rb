class CreateContactsPeople < ActiveRecord::Migration
  def change
    create_table :contacts_people do |t|
      t.integer :account_id, null: false
			t.string :type
      t.string :first_name, null: false, limit: 30
      t.string :middle_name, limit: 30
      t.string :last_name, null: false, limit: 30
			t.string :suffix, limit: 10
			t.string :gender, limit: 10
			t.date :birth_date
			t.string :email, limit: 50
			t.boolean :active, null: false, default: true

      t.timestamps null: false
    end
		add_index :contacts_people, :account_id
  end
end
