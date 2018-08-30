    class PostsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @posts = Post.all
        render json: @posts
        #respond_to do |format|
        #  format.html
        #  format.json {render :json => @posts}
        #end
      end

      def show
      end

      def new
        @posts = Post.new #新しいレコード、初期値設定なし
      end

      def edit
        @post = Post.find(params[:id])
        render json: @post
      end

      def create
        p "**************************"
        p "**************************"
        p  post_params.to_hash
        p "**************************"
        p "**************************"

        @post = Post.new(post_params) #post_paramsを下部にprivateで記載
        #今使わないので一旦コメントアウト。@post.picture = params[:picture].read  # readメソッドでバイナリデータに変換
        @post.save
        #render "file:///Users/kankehayata/workspace/vue_store/index.html"  #これで一覧に戻るけどこれでいいんか
      end

      def update
        @post = Post.find(params[:id])
        @post.name = params[:name]
        @post.contents = params[:contents]
        @post.price = params[:price]
        if params[:picture] != nil  # 画像ファイルの更新がなかった場合に変更しないように設定
          @post.picture = params[:picture].read
        end
        @post.save
      end

      def destroy
        @post = Post.find(params[:id])
        @post.destroy
        #@post = Post.all
        #respond_to do |format|
        #  format.html　{render "index"}
        #  format.json {render :json => @post}
        #end
      end

      def search
        # @posts = Post.where(params.permit(:name))  # <= 完全一致検索
        @posts = Post.where("name like '%"+ params[:name] +"%'") # <= 部分一致検索
        render :json => @posts
      end

      def get_image
        @posts = Post.find(params[:id])
        send_data(@posts.picture,:disposition => "inline",:type => "image.png/image.jpeg/image.jpg")
      end
    private
      def post_params
        #p "=========================="
        #p "=========================="
        #p  params.t
        #p "=========================="
        #p "=========================="
        params.permit(:name,:contents,:price,:picture)
      end

    end
=begin
  end
end
=end
