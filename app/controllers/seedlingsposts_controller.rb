class SeedlingspostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

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
    @seedlingspost.destroy
    flash[:success] = "苗情報を削除しました！"
    redirect_to request.referrer || root_url
  end

  private

    def seedlingspost_params
      params.require(:seedlingspost).permit(
        :item, :product_regulation, :shipping_date, :scion, :rootstock, :count, :location, :order_unit, :remarks, :picture
      )
    end

    def correct_user
      @seedlingspost = current_user.seedlingsposts.find_by(id: params[:id])
      redirect_to root_url if @seedlingspost.nil?
    end
end
