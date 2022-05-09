class PagesController < ApplicationController
    def home
        redirect_to articles_path if user_signed_in?
    end
end
