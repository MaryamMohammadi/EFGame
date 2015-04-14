class GameRostersController < ApplicationController
  before_action :set_game_roster, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @game_rosters = GameRoster.all
    respond_with(@game_rosters)
  end

  def show
    @items = Item.all
    respond_with(@game_roster)
  end

  def new
    @game_roster = GameRoster.new
    respond_with(@game_roster)
  end

  def edit
  end

  def create
    @game = Game.find(params[:game_id])
    @game_roster = @game.game_rosters.new()
    @game_roster.player = current_user
    current_user.game_rosters << @game_roster
    
    validate_action_create
    @game_started = true if game_is_starting?
    
    respond_to do |format|
      if @game_roster.save
        format.html { redirect_to @game_roster, notice: 'game_roster was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game_roster }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @game_roster.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    flash[:notice] = 'GameRoster was successfully updated.' if @game_roster.update(game_roster_params)
    respond_with(@game_roster)
  end

  def destroy
    @game_roster.destroy
    respond_with(@game_roster)
  end
  
  private
    def game_is_starting?
      return @game.players.count >= @game.number_of_players
    end
    def game_is_full?
      return @game.players.count > @game.number_of_players
    end
    
    def validate_action_create
      @errors = []
      if game_is_full?
        @errors << 'ظرفیت این بازی تکمیل است'
      end
      if @game.players.where(:id => current_user.id).count != 0 and game_is_starting?
        @errors << 'شما قبلا به این بازی پیوسته اید و بازی شروع شده است.'
      end
    end
    
    def set_game_roster
      @game_roster = GameRoster.find(params[:id])
    end

    def game_roster_params
      params.require(:game_roster).permit(:game_id, :player_id)
    end
end