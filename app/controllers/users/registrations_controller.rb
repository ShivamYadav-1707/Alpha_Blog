# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  prepend_before_action :require_no_authentication, only: [ :cancel]

  # GET /resource/sign_up
  def new
    if user_signed_in?
      if current_user.is_admin?
        super
      else
        flash[:danger]="User is already signed-in"
        redirect_to root_path
      end
    else
      super
    end
    
  end

  # POST /resource
  def create
    if params[:user][:is_admin]=="true"
      params[:user][:is_admin]=true
    end
    @user=User.new(user_params)
    if user_signed_in?
      if current_user.is_admin?
        if @user.save
          flash[:success]="users created successfully"
          redirect_to users_path
        else
            render :new, status: :unprocessable_entity
        end
      end
    else
      if @user.save
        flash[:notice]="user created successfully"
        redirect_to new_user_session_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # GET /resource/edit
  def edit
    if user_signed_in?
      super
    else
      redirect_to root_path
    end
  end

  # PUT /resource
  def update
    if user_signed_in?
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, location: edit_user_registration_path(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /resource
  def destroy
    super
    users_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender, :phone, :password, :cover_picture,:is_admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :phone,  :cover_picture,:is_admin])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :phone,  :cover_picture])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
      new_user_session_path
  end
  

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
  private 
  def user_params
    params.require(:user).permit(:name, :email, :gender, :phone, :password, :cover_picture,:is_admin)
  end
  def after_update_path_for(resource)
  end

end
