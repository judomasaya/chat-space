class MessagesController < ApplicationController
  before_action :set_group
  # すでに定義されているアクションが実行される前に
  # 自動で作動してくれるフィルタリング。
  # 綺麗にまとめるときに使用する。
  # どれをまとめたんだ？？


  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # includesメソッドはN+1問題を解消することができます。
    # 指定された関連モデルをまとめて一緒に取得しておくことで、
    # SQLの発行回数を減らすことができます。
    
    # 例：postsテーブルのレコードは必ず1つの
    # usersテーブルのレコードに属しているので、
    # includesメソッドを利用することで
    # postsテーブルのレコードを取得する段階で関連する
    # usersテーブルのレコードも一度に取得することができます。


  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])

  #  一番上のbefore_actionを使用する際に
  #  これを記述する



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
# end