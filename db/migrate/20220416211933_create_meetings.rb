class CreateMeetings < ActiveRecord::Migration[7.0]
  def up
    create_table :meetings do |t|
      t.integer :room
      t.date :date
      t.time :initial_time
      t.time :final_time
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :meetings
  end
end
