# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  protect_from_forgery except: :respond_to_on_destroy
  
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end
    
  

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end

  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }
    users.all?(&:blank?)
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    redirect_to new_user_session_path
  end

end