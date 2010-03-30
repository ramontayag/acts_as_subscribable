class CreateDorkuses < ActiveRecord::Migration
  def self.up
    create_table :dorkuses do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :dorkuses
  end
end
