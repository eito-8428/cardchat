class YugiohsController < ApplicationController
  def index
    @yugiohs = Yugioh.all
  end

  def new
    @yugioh = Yugioh.new
  end

  def create
    @yugioh = current_user.yugiohs.new(yugioh_params)
    
    if @yugioh.save
      redirect_to "/yugiohs/index", success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @yugioh = Yugioh.find(params[:id])
    @yugioh.destroy
    redirect_to yugiohs_path
  end

  private
  def yugioh_params
    params.require(:yugioh).permit(:time, :schedule, :description)
  end
end
