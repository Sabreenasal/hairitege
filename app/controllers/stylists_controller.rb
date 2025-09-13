class StylistsController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @stylist = current_user
    @clients = @stylist.clients.reload
    @new_client = User.new
  end
def create_client
  @new_client = User.new(client_params)

  if @new_client.save
    # Ensure there is at least one product
    default_product = Product.first
    unless default_product
      flash[:alert] = "You must create a product before adding clients."
      redirect_to stylist_dashboard_path and return
    end

    # Create recommendation with default product
    Recommendation.create!(
      stylist_id: current_user.id,
      client_id: @new_client.id,
      product_id: default_product.id
    )

    redirect_to stylist_dashboard_path, notice: "Client added successfully."
  else
    # Log errors for debugging
    Rails.logger.debug @new_client.errors.full_messages

    # Re-render dashboard with errors displayed
    @stylist = current_user
    @clients = @stylist.clients
    flash.now[:alert] = @new_client.errors.full_messages.join(", ")
    render :dashboard
  end
end


  private

  def client_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
