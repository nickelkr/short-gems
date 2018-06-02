class FilmsController < ApplicationController
  def create
    Film.create(film_params)
  end

  def index
  end

  def destroy
  end

  def new
  end

  private
    def film_params
      params.require(:film).permit(:title, :runtime, :external_id)
    end
end
