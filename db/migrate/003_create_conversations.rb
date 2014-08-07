class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.integer :id
      t.integer :user_id
      t.integer :issue_id
      t.text :value
      t.string :status
      t.string :is_solution, :limit => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
