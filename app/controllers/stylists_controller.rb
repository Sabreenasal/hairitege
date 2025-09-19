class StylistsController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @stylist = current_user
    @clients = @stylist.clients.reload
    @new_client = User.new
  end

  def create_client
    @new_client = User.new(client_params)
    @new_client.role = "client"

    if @new_client.save
      default_product = Product.first
      unless default_product
        flash[:alert] = "You must create a product before adding clients."
        redirect_to stylist_dashboard_path and return
      end

      Recommendation.create!(
        stylist_id: current_user.id,
        client_id: @new_client.id,
        product_id: default_product.id,
      )

      redirect_to stylist_dashboard_path, notice: "Client added successfully."
    else
      # If save failed, re-render dashboard with errors
      Rails.logger.debug @new_client.errors.full_messages
      @stylist = current_user
      @clients = @stylist.clients.reload
      flash.now[:alert] = @new_client.errors.full_messages.join(", ")
      render :dashboard
    end
  end

  def remove_client
    @stylist = current_user
    client = User.find(params[:id])

    if @stylist.clients.delete(client)
      redirect_to stylist_dashboard_path, notice: "#{client.name} has been removed from your clients."
    else
      redirect_to stylist_dashboard_path, alert: "Could not remove #{client.name}."
    end
  end

  private

  def client_params
    params.require(:user).permit(:name, :email, :password)
  end
end

