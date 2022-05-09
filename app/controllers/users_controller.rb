class UsersController < ApplicationController
    def index
        
        if user_signed_in?
            @q = User.ransack(params[:q])
            @user = @q.result(distinct: true).order('created_at desc').paginate(page: params[:page], per_page:10)
        else
            redirect_to root_path
        end
    end
    def show
        if user_signed_in?
            @user=User.find(params[:id])
            @articles = @user.articles.order('created_at desc').paginate(page: params[:page], per_page: 3)
        else
            redirect_to root_path
        end
    end
    def destroy
        @user=User.find(params[:id])
        if user_signed_in? 
            if can? :update, @user
                @user.destroy
                redirect_to root_path,status: :see_other
            else
                flash[:danger]="You can delete your info only"
                redirect_to user_session
            end
        end
    end




    
    private
        def params_edit
            params.require(:user).permit(:name, :gender, :phone,:password,  :cover_picture)
        end

end
