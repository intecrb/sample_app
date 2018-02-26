class SessionsController < ApplicationController
  def new
  end

  def create
    # メールアドレスはdowncaseで登録してあります
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザログイン後にユーザ情報のページにリダイレクトする
    else
      # エラーメッセージを表示する
      flash[:danger] = 'Invalid email/password combination' # ほんとは正しくない
      render 'new'
    end
  end

  def destroy
  end
end
