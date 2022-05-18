class CommentsController < ApplicationController

  # GET /comments or /comments.json

  # GET /comments/1 or /comments/1.json

  # GET /comments/new

  # GET /comments/1/edit

  # POST /comments or /comments.json
  def create
    @article=Article.find(params[:article_id])
    @comment=@article.comments.create(comment_params)
    @comment.user_id=current_user.id
    if @comment.save
        redirect_to article_path(@article)
    else
        flash[:danger]="Incomplete comment forms" 
        redirect_to @article
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to (@article), status: 303
  end

  private
  private
  def comment_params
      params.require(:comment).permit(:comment)
  end
end
