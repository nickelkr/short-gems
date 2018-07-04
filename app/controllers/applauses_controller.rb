class ApplausesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    film = Film.find(params[:film])
    applause = film.applauses.create(user: current_user, category: params[:category])

    render json: { applause: 
                     { id: applause.id,
                       total: film.applauses.count},
                   film:
                     { id: film.id }
                 }
  end

  def destroy
    applause = current_user
                .applauses
                .where(id: params[:id])
                .first

    film = applause.film

    applause.destroy if applause

    render json: { applause:
                     { total: film.applauses.count},
                   film:
                     { id: film.id}
                 }
  end
end
