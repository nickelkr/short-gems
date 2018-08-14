include Pagy::Backend

class FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy new]

  def create
    link = film_params[:external_id]

    source_info = ExternalIDExtractor.new(link).perform
    film = current_user.films.build(film_params.merge(source_info)) if source_info.present?

    film.save ? flash[:success] = 'Film added' : flash[:error] = film.errors.full_messages.first

  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to films_path
  end

  def index
    @pagy, @films = pagy(Film.all.order(created_at: :desc), items: 25)
  end

  def show
    @film = Film.find_by_id(params[:id])

    unless @film.present?
      flash[:error] = "Film not found"
      redirect_to films_path
    end
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
