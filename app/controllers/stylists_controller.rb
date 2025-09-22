class StylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_stylist!

  def dashboard
    @stylist = current_user
    @clients = @stylist.clients.reload
    @new_client = User.new

    @breadcrumbs = [
      ["Home", root_path],
      ["Dashboard", stylist_dashboard_path]
    ]
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
        stylist: current_user,
        client: @new_client,
        product: default_product
      )

      redirect_to stylist_dashboard_path, notice: "Client added successfully."
    else
      # If save failed, re-render dashboard with errors
      Rails.logger.debug @new_client.errors.full_messages
      @stylist = current_user
      @clients = @stylist.clients.reload
      flash.now[:alert] = @new_client.errors.full_messages.join(", ")
      @breadcrumbs = [
        ["Home", root_path],
        ["Dashboard", stylist_dashboard_path]
      ]
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

  def ensure_stylist!
    redirect_to root_path, alert: "Access denied" unless current_user.stylist?
  end
end
