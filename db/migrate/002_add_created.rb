class AddCreated < ActiveRecord::Migration
  def self.up
    add_column :posts, :created, :timestamp
  end

  def self.down
    remove_column(:posts, :created)
  end
end
