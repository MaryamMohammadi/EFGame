class Game < ActiveRecord::Base
	belongs_to :creater, :class_name => "User"
  has_many :game_rosters
  has_many :players, through: :game_rosters, :source => :player
  has_many :round_letters
  has_many :round_letters
end
