ActiveRecord::Schema.define(:version => 0) do
	create_table :users, :force => true do |t|
		t.string :login
		t.string :email
	end
	
	create_table :subscriptions, :force => true do |t|
		t.string :subscribable_type
		t.integer :subscribable_id
		t.integer :subscriber_id
		t.string :subscriber_type
		t.string :email
	end

	create_table :dorkuses, :force => true do |t|
		t.string :name
	end
end
