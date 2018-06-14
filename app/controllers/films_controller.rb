class FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy new]

  def create
    current_user.films.create(film_params)
    flash[:success] = 'Film created'

    redirect_to films_path
  end

  def index
    @films = Film.all.order(created_at: :desc)
  end

  def destroy
    film = Film.where(id: params[:id]).first
    
    if film.nil?
      flash[:error] = "Film not found"
    elsif film.user_id == current_user.id || current_user.roles.admin?
      film.destroy
      flash[:success] = "Film removed"
    else
      flash[:error] = "You are not allowed to remove this film"
    end

    redirect_to films_path
  end

  def new
    @film = Film.new
  end

  private
    def film_params
      params.require(:film).permit(:title, :runtime, :external_id)
    end
end
