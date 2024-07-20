class HomeController < ApplicationController
  def index
    redirect_to contexts_path if Current.user
  end
end
