class AdminController < ApplicationController
    def new
        @user=User.new
        respond_to do |format|
            format.html
            format.js
          end
    end
    def create
        @user=User.new(user_params)
        respond_to do |format|
            if @user.save
                flash.now[:notice]="User created successfully"
                @users=User.all.order('created_at desc').paginate(page: params[:page], per_page: 10)
                format.js { render :file => "admin/success.js.erb" }
            else
                format.js { render :file => "admin/create.js.erb", locals: {:message => "New User could not be created"}}
            end
        end
    end
    def edit
        @user=User.find(params[:id])
    end

    def update
        @user=User.find(params[:id])
        if @user.update(edit_params)
            flash[:notice]="User updated Successfully"
            redirect_to @user
        else
            render :edit, :status => :unprocessable_entity
        end
    end
    private
    def user_params
      params.require(:user).permit(:name, :email, :gender, :phone, :password, :cover_picture,:is_admin)
    end
    def edit_params
        params.require(:user).permit(:name, :gender, :phone, :cover_picture)
    end
end
