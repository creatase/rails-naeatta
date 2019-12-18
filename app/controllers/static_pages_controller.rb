class StaticPagesController < ApplicationController
  def home
    @seedlingspost = current_user.seedlingsposts.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
