class ApplausesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    film = Film.find(params[:film])
    applause = film.applauses.create(user: current_user, category: params[:category])

    render json: { applause: { id: applause.id }}
  end

  def destroy
    applause = current_user
                .applauses
                .where(id: params[:id])
                .first

    applause.destroy if applause
  end
end
