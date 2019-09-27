class HomeController < ApplicationController
	# skip_before_action :authenticate_user!, only: [:show, :index]
  skip_before_action :authenticate_user!, only: [:index]

  def index
  	# redirect_to page2_path
  	# automatically redirect user to his/her homepage if already signed in
  	# Refer: https://stackoverflow.com/a/28596567/6543250
  	if user_signed_in?
      redirect_to user_homepage_path
    end
  end

end
