# まず、/spec/supportディレクトリに、controller_macros.rbを作成し、
# loginメソッドを定義します。

module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end

# その後、rails_helper.rbに、deviseのコントローラのテスト用のモジュールと、
# 先ほど定義したControllerMacrosを読み込む記述を行います。