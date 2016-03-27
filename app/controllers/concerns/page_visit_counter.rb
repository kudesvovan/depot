module PageVisitCounter
	extend ActiveSupport::Concern

	private

	def set_counter
  	if session[:counter].nil?
  		session[:counter] = 0
  	else
  		session[:counter]
  	end
  end

  def increase_counter
  	session[:counter] += 1
  end

  def reset_counter
  	session[:counter] = 0
  end
end