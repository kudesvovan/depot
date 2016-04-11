class StoreController < ApplicationController
	skip_before_action :authorize

  include PageVisitCounter
  include CurrentCart

  before_action :set_cart

  def index
  	if params[:set_locale]
  		redirect_to store_url(locale: params[:set_locale])
  	else
  		@products = Product.order(:title)
  	end
		
		set_counter
		@session_counter = increase_counter 
  end
end
