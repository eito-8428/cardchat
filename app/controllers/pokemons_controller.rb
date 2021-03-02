class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = current_user.pokemons.new(pokemon_params)
    
    if @pokemon.save
      redirect_to "/pokemons/index", success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    redirect_to pokemons_path
  end

  private
  def pokemon_params
    params.require(:pokemon).permit(:time, :schedule, :description)
  end
end