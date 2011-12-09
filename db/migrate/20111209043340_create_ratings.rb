class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :ticket
      t.string :access_key
      t.string :value
      t.string :agent_email

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
