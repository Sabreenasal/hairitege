class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recommendation, only: [:update, :destroy]


  def index
  @client = User.find_by(id: params[:client_id])
  unless @client
    redirect_to root_path, alert: "Client not found"
    return
  end

   redirect_to new_client_recommendation_path(@client)
end


  def new
    @client = User.find_by(id: params[:client_id])
    unless @client
      redirect_to root_path, alert: "Client not found"
      return
    end

 
    @shampoo = Product.find_by(name: "Gentle Shampoo")
    @conditioner = Product.find_by(name: "Hydrating Conditioner")

 
    @recommendation = Recommendation.new(client: @client, stylist: current_user)
  end

  
  def create
    @client = User.find_by(id: params[:client_id])
    unless @client
      redirect_to root_path, alert: "Client not found"
      return
    end

    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.client = @client
    @recommendation.stylist = current_user

    if @recommendation.save
      redirect_to client_recommendations_path(@client), notice: "Product recommended!"
    else
      flash.now[:alert] = @recommendation.errors.full_messages.join(", ")
      render :new
    end
  end

def update
    if @recommendation.update(recommendation_params)
     
      redirect_to mane_vault_client_path(@recommendation.client), notice: "Notes updated successfully"
    else
    
      @client = @recommendation.client
      @recommendations = @client.recommendations.includes(:product)
      flash.now[:alert] = "Failed to update notes"
      render 'clients/mane_vault', status: :unprocessable_entity
    end
  end


def destroy
  @recommendation = Recommendation.find(params[:id])
  @client = @recommendation.client
  @recommendation.destroy

  redirect_path = params[:redirect_to].presence || client_recommendations_path(@client)
  
  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to redirect_path, notice: "Recommendation removed!" }
  end
end

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  def recommendation_params
    params.require(:recommendation).permit(:product_id, :notes)
  end
end
