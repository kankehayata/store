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
    @posts.picture = params[:picture].read  # readメソッドでバイナリで読み込むのでは？
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
    @posts = Post.where(params.permit(:name))  # 検索ワードが含まれるレコードのみをindexとして表示　これpermitじゃなくても上手くいきそうだけどなんで駄目？whereメソッドの問題な気がする
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
