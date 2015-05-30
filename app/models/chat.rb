class Chat < ActiveRecord::Base
  belongs_to :game
  belongs_to :sender, :class_name => "User"
  validates_presence_of :game_id, :sender_id
end
