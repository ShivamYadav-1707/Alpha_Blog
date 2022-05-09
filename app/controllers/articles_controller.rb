class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_admin!, only: [:action]
  def index
      @article=Article.all
  end
  def show
      if user_signed_in?
          @articles=Article.find(params[:id])
      else
          redirect_to root_path
      end
  end
  def new 
      if user_signed_in?
          @articles=Article.new
      else
          redirect_to root_path
      end
  end
  def create
      if user_signed_in?
          @articles=Article.new(article_params)
          @articles.user_id = current_user.id
          if @articles.save
              flash[:success]="Article created successfully"
              redirect_to @articles
          else
              render :new, status: :unprocessable_entity
          end
      else
          flash[:danger]="You need to sign in first"
          redirect_to root_path
      end
  end
  def edit
      if user_signed_in?
          @articles=Article.find(params[:id])
      else
          redirect_to root_path
      end
  end
  def update
      @articles=Article.find(params[:id])
      if user_signed_in? 
        if (can? :update, @articles)
          if @articles.update(article_params)
              flash[:success]="Article updated successfully"
              redirect_to @articles
          else
              render :edit, status: :unprocessable_entity
          end
        else
            flash[:danger]="You can only update your own article"
            redirect_to root_path
        end
    end
  end
  def destroy
      @articles=Article.find(params[:id])
        if user_signed_in? 
            if can? :update, @articles
                @articles.destroy
                redirect_to root_path,status: :see_other
            else
                flash[:danger]="You can only update your own article"
                redirect_to root_path
            end
        end
  end




  
  private
  def article_params
      params.require(:article).permit(:title, :description)
  end
end