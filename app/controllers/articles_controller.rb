class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :set_article, only:[:show,:edit,:update,:destroy]
  def index
      @article=Article.all.order('created_at desc')
  end
  def show
  end
  def new 
    @articles=Article.new
  end
  def create
    @articles=Article.new(article_params)
    @articles.user_id = current_user.id
    if @articles.save
        flash[:success]="Article created successfully"
        redirect_to @articles
    else
        render :new, status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
    if (can? :update, @articles)
        if @articles.update(article_params)
            flash[:success]="Article updated successfully"
            redirect_to @articles
        else
            render :edit, status: :unprocessable_entity
        end
    end
  end
  def destroy
    if can? :update, @articles
        @articles.destroy
        redirect_to root_path,status: :see_other
    else
        flash[:danger]="You can only update your own article"
        redirect_to root_path
    end
  end
  
  private
  def article_params
      params.require(:article).permit(:title, :description)
  end
  def set_article
    @articles=Article.find(params[:id])
  end
end