class ChatsController < ApplicationController

  def index
    @chats = Chat.all
    @user = @current_user
    @currentEntries = current_user.entries
    myChatIds = []
  
    @currentEntries.each do |entry|
      myChatIds << entry.chat.id     
    end
    
    @anotherEntries = Entry.where(chat_id: myChatIds).where.not(user_id: current_user.id)
  end
  
  def create
      @chat = Chat.create
      @entry1 = Entry.create(:chat_id => @chat.id, :user_id => current_user.id)
      @entry2 = Entry.create(params.require(:entry).permit(:user_id, :chat_id).merge(:chat_id => @chat.id))
      redirect_to "/chats/#{@chat.id}"
    end
  
    def show
      @chat = Chat.find(params[:id])
      if Entry.where(:user_id => current_user.id, :chat_id => @chat.id).present?
        @messages = @chat.messages
        @message = Message.new
        @entries = @chat.entries
      else
        redirect_back(fallback_location: root_path)
      end
    end
end
