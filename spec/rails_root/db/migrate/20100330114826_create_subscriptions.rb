class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :subscribable_type
      t.integer :subscribable_id
      t.string :subscriber_type
      t.integer :subscriber_id
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
