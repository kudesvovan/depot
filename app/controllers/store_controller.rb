class StoreController < ApplicationController
  include PageVisitCounter

  def index
  	@products = Product.order(:title)
		
		set_counter
		@session_counter = increase_counter 
  end
end
