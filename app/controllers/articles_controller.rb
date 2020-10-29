class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
        #byebug
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 2)
    end

    def new
        @article = Article.new #have to add i30n otder 30to avoid error in new.html.erb
    end

    def edit
    end

    def create
        art = params[:article]
        @article = Article.new(article_params) #whitelisting
        #@article.user = User.first #hard coding
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else
            render "new"            
        end
        #redirect_to article_path(@article)
        #or
        #redirect_to @article
    end

    def update 
        if @article.update(article_params)
            flash[:notice] = "Updated successfully"
            redirect_to @article
        else
            render 'edit'
            
        end
    end

    def destroy
        
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description) #whitelisting
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
        

end