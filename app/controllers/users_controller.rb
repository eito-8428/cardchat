class UsersController < ApplicationController
  before_action :login_check, only: [:show, :edit, :update, :destroy, :following, :followers]
  
  def index
    @users = User.all
  end
  
  def show
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.chat_id == u.chat_id then
            @isChat = true
            @chatId = cu.chat_id
          end
        end
      end
      if @isChat
      else
        @chat = Chat.new
        @entry = Entry.new
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.image = "default.png"
    if @user.save
      redirect_to login_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user), success: '編集が完了しました'
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def follows
    @user  = User.find(params[:id])
    @users = @user.follows
    render 'show_follow'
  end
    
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :category, :introduction)
  end


end

