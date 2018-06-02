class FilmsController < ApplicationController
  def create
    Film.create(film_params)
  end

  def index
  end

  def destroy
    Film.destroy(params[:id])
  end

  def new
    @film = Film.new
  end

  private
    def film_params
      params.require(:film).permit(:title, :runtime, :external_id)
    end
end
