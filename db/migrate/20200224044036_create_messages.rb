class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    # メッセージテーブルを作成
    create_table :messages do |t|
      # string=短文のコンテントカラムを追加-入力したmessageが入ってる
      t.string :content
      # 短文のイメージカラムを追加ー写真が入る所
      t.string :image
      # 外部キーーグループとユーザーにかけてる
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

# アクティブレコード
# messagesテーブル（Messageモデル）
# message = Message.find[2]
# これでmessagesテーブルの２番（孫悟空の情報）を変数messageに入れて

# message.content
# とすると
# 孫悟空のコンテントのみ取得できる