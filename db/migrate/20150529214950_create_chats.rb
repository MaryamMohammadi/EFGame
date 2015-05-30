class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :game_id
      t.integer :sender_id
      t.string :text

      t.timestamps
    end
  end
end
