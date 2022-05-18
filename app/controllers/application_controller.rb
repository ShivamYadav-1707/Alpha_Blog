class ApplicationController < ActionController::Base
    add_flash_types :danger, :info, :warning, :success
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :resource_name, :resource, :devise_mapping, :resource_class
    
    rescue_from CanCan:: AccessDenied do |exception|
        redirect_to root_path, :alert => exception.message
    end
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender, :phone, :password, :cover_picture,:is_admin])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :phone, :cover_picture])        
    end

    def resource_name
        :user
    end

    
    
    def resource
        @resource ||= User.new
    end
    def resource_class
        User
    end
    
    def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
    end


    
    protected
    def authenticate_admin!
        authenticate_user!
        redirect_to :somewhere, status: :forbidden unless current_user.is_admin?
    end
      

        
end
