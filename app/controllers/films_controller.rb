class FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy new]

  def create
    link = film_params[:external_id]

    case link
    when /^https?:\/\/youtu\.be\/[a-zA-Z0-9_-]+$/,
      /^https?:\/\/youtube.com\/[a-zA-Z0-9_-]+$/,
      /^https?:\/\/www.youtube.com\/watch\?v=[a-zA-Z0-9_-]+$/,
      /^https?:\/\/youtube.com\/watch\?v=[a-zA-Z0-9_-]+$/
      current_user.films.create(film_params)
      flash[:success] = 'Film added'
    else
      flash[:error] = 'Only YouTube videos are currently supported.'
    end

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
    flash[:warning] = 'We currently only support YouTube, but we\'re working hard to integrate other sources.'
  end

  private
    def film_params
      params.require(:film).permit(:title, :runtime, :external_id)
    end
end
