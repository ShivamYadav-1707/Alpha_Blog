class UsersController < ApplicationController
    load_and_authorize_resource
    before_action :set_user, only:[:show,:destroy]

    def index
        @users=User.all.order('created_at desc').paginate(page: params[:page], per_page: 10)
        @user=User.new
    end

    def search_result
        
        if (params[:gender]!=nil && params[:name]=="")
            @users=User.where("gender like ?",params[:gender]).order('created_at desc').paginate(page: params[:page], per_page: 10)
        elsif (params[:name]!="" && params[:gender]==nil)
            s="%#{params[:name]}%"
            @users=User.where("name like ? or email like ? or phone like ?", s,s,s).order('created_at desc').paginate(page: params[:page], per_page: 10)
        elsif (params[:name]!="" && params[:gender]!=nil)
            s="%#{params[:name]}%"
            @users=User.where("(name like ? or email like ? or phone like ?) and gender like ?", s,s,s,params[:gender]).order('created_at desc').paginate(page: params[:page], per_page: 10)
        else
            @user=User.all.order('created_at desc').paginate(page: params[:page], per_page: 10)
        end
        respond_to do |format|
            format.js { render :file => "users/index.js.erb"}
        end 
    end


    def show
        @articles = @user.articles.order('created_at desc').paginate(page: params[:page], per_page: 3)
    end


    def destroy
        if can? :update, @user
            @user.destroy
            redirect_to users_path,status: :see_other
        else
            flash[:danger]="You can delete your info only"
            redirect_to user_session
        end
    end

    
    private
        def set_user
            @user=User.find(params[:id])
        end
        def params_edit
            params.require(:user).permit(:name, :gender, :phone,:password,  :cover_picture)
        end

end
