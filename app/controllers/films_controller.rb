class FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy new]

  def create
    current_user.films.create(film_params)
  end

  def index
    @films = Film.all.order(created_at: :desc)
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
