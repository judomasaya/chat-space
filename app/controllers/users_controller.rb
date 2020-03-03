class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end



# 基礎カリキュラムの例

# form_tagを使用した時のストロングパラメーター
# def strong_params
#   params.permit(`カラム名`)
# end


# # form_withを使用した時ストロングパラメーターの書き方は変わる！！！
# def strong_params
#   params.require(`モデル名`).permit(`カラム名`)
# end＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿（許可）