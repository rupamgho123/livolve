class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :id
      t.integer :team_id
      t.string :auth_token
      t.string :name
      t.string :email
      t.string :role
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
