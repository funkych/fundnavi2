class ProductsController < ApplicationController

  def index
    # productsテーブルから最新順に作品を２０件取得する
    @products = Product.order('id ASC').limit(20)
  end

  def show
    # productsテーブルから該当するidの作品productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
  end

end
