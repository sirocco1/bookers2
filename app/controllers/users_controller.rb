class UsersController < ApplicationController
	before_action :authenticate_user!
	#ビフォーアクションはこのコントローラーが実行される前という意味
	#authenticate userはdeviseで用意されているメソッドで、ログイン認証がされていないとrootパスにリダイレクトされる。
	#アプリケーションコントローラーに記述すれば全適用されるが、今回はhomeコントローラーは適用したくないので、booksとusersに適用
	before_action :baria_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :avatar_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to root_url
  	end
   end

end
