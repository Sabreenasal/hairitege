class ClientsController < ApplicationController
  before_action :authenticate_user!

  def mane_vault
    # Accept either :id or :client_id (depending on route)
    client_id = params[:id] || params[:client_id]
    @client = User.find_by(id: client_id)

    unless @client
      flash[:alert] = "Client not found"
      redirect_to root_path and return
    end

    # Preload recommendations with their products
    @recommendations = @client.recommendations.includes(:product)
  end
end
