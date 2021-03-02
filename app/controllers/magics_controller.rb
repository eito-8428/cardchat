class MagicsController < ApplicationController
  def index
    @magics = Magic.all
  end

  def new
    @magic = Magic.new
  end

  def create
    @magic = current_user.magics.new(magic_params)
    
    if @magic.save
      redirect_to "/magics/index", success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @magic = Magic.find(params[:id])
    @magic.destroy
    redirect_to magics_path
  end

  private
  def magic_params
    params.require(:magic).permit(:time, :schedule, :description)
  end
end
