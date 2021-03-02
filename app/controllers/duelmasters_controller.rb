class DuelmastersController < ApplicationController
  def index
    @duelmasters = Duelmaster.all
  end

  def new
    @duelmaster = Duelmaster.new
  end

  def create
    @duelmaster = current_user.duelmasters.new(duelmaster_params)
    
    if @duelmaster.save
      redirect_to "/duelmasters/index", success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @duelmaster = Duelmaster.find(params[:id])
    @duelmaster.destroy
    redirect_to duelmasters_path
  end

  private
  def duelmaster_params
    params.require(:duelmaster).permit(:time, :schedule, :description)
  end
end


