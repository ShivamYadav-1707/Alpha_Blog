# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create,:update]
  prepend_before_action :require_no_authentication, only: [ :cancel]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    if params[:user][:is_admin]=="true"
      params[:user][:is_admin]=true
    end
    @user=User.new(user_params)
    if @user.save
      flash[:notice]="User created successfully"
      redirect_to new_user_session_path
    else
      render :new, status: :unprocessable_entity
    end
    # super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update_resource(resource, params)
    resource.update_without_password(params.except("current_password"))
  end

  # DELETE /resource
  def destroy
    super
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
 
  # If you have extra params to permit, append them to the sanitizer.
 

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
