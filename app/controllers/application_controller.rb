
class ApplicationController < ActionController::Base
	before_action :authorize, :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
 	
		def authorize 
  		if User.count.zero?
  			redirect_to new_user_path, notice: "Пожалуйста, создайте первого пользователя"
  		else
	  		if request.format == Mime::ATOM
	  			user = authenticate_or_request_with_http_basic do |name, password|
	  				User.find_by_name(name).try(:authenticate, password)
	  			end
	  		else
	  			user = User.find_by(id: session[:user_id])
	  		end


	  		redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию" unless user
  		end
  	end

  	def set_i18n_locale_from_params
  		if params[:locale]
  			if I18n.available_locales.map(&:to_s).include?(params[:locale])
  				I18n.locale = params[:locale]
  			else
  				flash.now[:notice] = "#{params[:locale]} translation not available"
  				logger.error flash.now[:notice]
  			end
  		end
  	end

  	def default_url_options
  		{ locale: I18n.locale }
  	end
end
