class ChatsController < ApplicationController
#before_action :set_chat, only: [:show, :edit, :update, :destroy]

  respond_to :html

  # def index
#     @chats = Chat.all
#     respond_with(@chats)
#   end
#
#   def show
#     respond_with(@chat)
#   end

  def new
    @chat = Chat.new
    respond_with(@chat)
  end

  # def edit
#   end

  def create
    #game_board = GameBoard.find(params[:game_board_id])
    @game = Game.find(params[:game_id])
    @chat = @game.chats.new(chat_params)
    current_user.chats << @chat
    respond_to do |format|
      if @chat.save
        format.html { redirect_to current_user.game_boards.first, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chat }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
#     flash[:notice] = 'Chat was successfully updated.' if @chat.update(chat_params)
#     respond_with(@chat)
#   end
#
#   def destroy
#     @chat.destroy
#     respond_with(@chat)
#   end

  private
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def chat_params
      params.require(:chat).permit(:game_id, :sender_id, :text)
    end
end
