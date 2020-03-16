class Api::MessagesController < ApplicationController
  def index
    #今いるグループの情報をparamsによって取得しインスタンス変数@groupに代入
    @group = Group.find(params[:group_id]) 


     # idがパラメータで取得するidよりも大きいものを、@groupと関連するメッセージの中から検索する。
        # includesはN+1問題対策
    @messages = @group.messages.includes(:user).where('id > ?', params[:id])

#グループ内のメッセージでlast_idよりも大きいidのメッセージがないかを探してきてそれらを@messageに代入
    @messages = @group.messages.includes(:user).where('id > ?', params[:last_id])

    # html形式とjson形式のリクエストでそれぞれ振り分ける
    respond_to do |format|
      format.html
      format.json
  end
end
end
  