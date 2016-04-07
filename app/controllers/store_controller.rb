class StoreController < ApplicationController
	skip_before_action :authorize

  include PageVisitCounter
  include CurrentCart

  before_action :set_cart

  def index
  	@products = Product.order(:title)
		
		set_counter
		@session_counter = increase_counter 
  end
end
