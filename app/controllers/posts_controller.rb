class PostsController < ApplicationController

  def index
    @posts = Post.all  # ここのPostはmodel名なので単数形、ここではidも取得しているからedit用にも値を拾える
  end

  def show
  end

  def new
    @posts = Post.new #新しいレコード、初期値設定なし
  end

  def edit
    @posts = Post.find(params[:id])
  end

  def create
    @posts = Post.new(params.permit(:name,:contents,:price,:picture))
    @posts.picture = params[:picture].read  # readメソッドでバイナリデータに変換
    @posts.save
  end

  def update
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    @posts = Post.all
    render "index"
  end

  def search
    # @posts = Post.where(params.permit(:name))  # 検索ワードが含まれるレコードのみをindexとして表示　これpermitじゃなくても上手くいきそうだけどなんで駄目？whereメソッドの問題な気がする
    @posts = Post.where("name like '%"+ params[:name] +"%'") # <= 部分一致検索可能
    render "index"
  end

  def edit_save
    @posts = Post.find(params[:id])
    @posts.name = params[:name]
    @posts.contents = params[:contents]
    @posts.price = params[:price]
    @posts.picture = params[:picture].read
    @posts.save
  end

  def get_image
    @posts = Post.find(params[:id])
    send_data(@posts.picture,:disposition => "inline",:type => "image.png")
  end

end
