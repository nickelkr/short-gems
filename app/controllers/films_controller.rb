class FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy new]

  def create
    link = film_params[:external_id]

    if external_id = ExternalIDExtractor.new(link).perform
      current_user.films.create(film_params.merge({external_id: external_id}))
      flash[:success] = 'Film added'
    else
      flash[:error] = 'Only YouTube videos are currently supported.'
    end

  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to films_path
  end

  def index
    @pagy, @films = pagy(Film.all.order(created_at: :desc), items: 25)
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
