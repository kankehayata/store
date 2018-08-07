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
    @posts = Post.find(params[:id])
    @posts.name = params[:name]
    @posts.contents = params[:contents]
    @posts.price = params[:price]
    if params[:picture] != nil  # 画像ファイルの更新がなかった場合に変更しないように設定
      @posts.picture = params[:picture].read
    end
    @posts.save
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    @posts = Post.all
    render "index"
  end

  def search
    # @posts = Post.where(params.permit(:name))  # <= 完全一致検索
    @posts = Post.where("name like '%"+ params[:name] +"%'") # <= 部分一致検索
    render "index"
  end

  def get_image
    @posts = Post.find(params[:id])
    send_data(@posts.picture,:disposition => "inline",:type => "image.png/image.jpeg/image.jpg")
  end

end
