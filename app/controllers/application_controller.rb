class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # コントローラーの先頭に記載することで、
  # そこで行われる処理はログインユーザーによってのみ実行可能となります。
  # 下記の通り記載した場合、記事の一覧、
  # 詳細を確認することができるのはログインユーザーのみとなります。


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
