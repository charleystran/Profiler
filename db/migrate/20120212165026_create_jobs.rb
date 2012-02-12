class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :employer
      t.string :started
      t.string :ended
      t.text :description
    end
  end

  def self.down
    drop_table :jobs
  end
end
