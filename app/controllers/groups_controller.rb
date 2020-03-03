class GroupsController < ApplicationController


  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
# createアクションはフォームで送られてきた情報を元に、レコードを保存します。
# ストロングパラメーターも忘れずに設定しましょう。
    @group = Group.new(group_params)
    if @group.save
      # このリダイレクトにより投稿後はトップページへ遷移するはずです。
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end


  def edit
    @group = Group.find(params[:id])
    # editアクションを設定しました。
    # また、@groupには編集する情報が入るようになっています。

  end

  def update
    group = Group.find(params[:id])
    group.update(post_params)
    # post_paramsにおけるストロングパラメーターで許可されたパラメーターを、
    # updateアクションで受け取ります。groupには編集したいレコードの情報が入り、
    # groupをupdateメソッドによって更新しています。


    redirect_to group_path(group.id)
    # 変数groupには「今、更新した記事の情報」が入ります。
    # 次にgroup_path(group.id)とすることで、
    # リダイレクトする際に、:idにgroup.idが入ることになります。




    # 例@post = Post.find(params[:id])
    # ActiveRecordのメソッドfindメソッドを用いて
    # テーブルから一つのレコードを取得し、
    # @postに代入しています。
    # params[:id]は元々レコードのIDが入っていたので、
    # IDに該当するレコードの情報をテーブルから取得する。

  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      # このリダイレクトにより投稿後はトップページへ遷移するのでgroup一覧画面へ
      redirect_to group_messages_path(@group.id), notice: 'グループを更新しました'
      # root_pathをgroup_messages_path(@group.id)に変更
      # グループは複数あるので(@group.id)でどのgroupなのかを指定する。

    else
      render :edit
    end
  end


  private
  # これでグループモデルに名前と使用者の書き込み許可を出す
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
  # paramsというハッシュの中にさらにgroup
  # というハッシュが存在する二重構造になっているため、
  # params.require(:モデル名).permit(:カラム名)
  # で値を取得してあげなければいけません。

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