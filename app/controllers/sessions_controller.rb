class SessionsController < ApplicationController
  def new
    debugger
  end

  def create
    # メールアドレスはdowncaseで登録してあります
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # userをsessionに格納する
      log_in @user
      # remenberメソッドを使って、ログイン情報を記録させる
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # ユーザログイン後にデフォルトではユーザ情報のページにリダイレクトする。
      # sessionにurlが保存されていた場合は、そのページにリダイレクトする。
      redirect_back_or @user
    else
      # エラーメッセージを表示する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
