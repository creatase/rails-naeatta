class SeedlingspostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @seedlingspost = current_user.seedlingsposts.build(seedlingspost_params)
    if @seedlingspost.save
      flash[:succses] = "苗情報を投稿しました！"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def seedlingspost_params
      params.require(:seedlingspost).permit(
        :item, :product_regulation, :shipping_date, :scion, :rootstock, :count, :location, :order_unit, :remarks
      )
    end
end
