# モデルでテストすべきは以下の点です。

# メッセージを保存できる場合
# メッセージがあれば保存できる
# 画像があれば保存できる
# メッセージと画像があれば保存できる
# メッセージを保存できない場合
# メッセージも画像も無いと保存できない
# group_idが無いと保存できない
# user_idが無いと保存できない
# 今回の場合、テストのケースが
# メッセージを保存できる場合、
# メッセージを保存できない場合
# で分かれています。




# 今回の場合、テストのケースが
# メッセージを保存できる場合、
# メッセージを保存できない場合で分かれています。
# このように、特定の条件でテストをグループ分けしたい場合、
# contextを使うことができます。
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do


    
    
    # 〜メッセージを保存できる場合のテスト〜
    
    context 'can save' do
      #   ↓メッセージがあれば保存できる
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
      end
      # buildメソッドは、カラム名: 値の形で引数を渡すことによって、
      # ファクトリーで定義されたデフォルトの値を上書きすることができます。
      # 今回は、メッセージがあれば保存できることを確かめたいので、
      # image: nilを引数として、画像を持っていないインスタンスを生成します。


      # ↓画像があれば保存できる
      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end
      # 画像があれば保存できる場合についても、
      # content: nilをbuildメソッドの引数とすることによって、
      # メッセージを持っていないインスタンスを生成することができます。


      # ↓メッセージと画像があれば保存できる
      it 'is valid with content and image' do
        expect(build(:message)).to be_valid
      end
      # メッセージと画像があれば保存できる場合は、
      # ファクトリーでデフォルトの値が定義されているので、
      # build(:message)と記述するだけで、
      # メッセージと画像を持ったインスタンスを生成することができます。
    end





    # 〜メッセージを保存できない場合のテスト〜

    context 'can not save' do
      # ↓メッセージも画像も無いと保存できない
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end
      # メッセージも画像もないと保存できない場合については、
      # buildメソッドの引数でメッセージも画像もnilにすることによって、
      # 必要なインスタンスを生成することができます。
      # 作成したインスタンスがバリデーションによって
      # 保存ができない状態かチェックするため、valid?メソッドを利用します。

      # valid?メソッドを利用したインスタンスに対して、
      # errorsメソッドを使用することによって、
      # バリデーションにより保存ができない状態である場合なぜできないのかを
      # 確認することができます。

      # contentもimageもnilの今回の場合、
      # 'を入力してください'というエラーメッセージが含まれることが分かっているため、
      # includeマッチャを用いて以下のようにテストを記述することができます。

      # expectの引数に関して、message.errors[:カラム名]と記述することによって、
      # そのカラムが原因のエラー文が入った配列を取り出すことができます。
      # こちらに対して、includeマッチャを利用してエクスペクテーションを作っています。




      # ↓user_idが無いと保存できない かつ group_idが無いと保存できない
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
      # 最後に、group_idが無いと保存できない場合、
      # user_idが無いと保存できない場合に関してですが、
      # これらもメッセージも画像もないと保存できない場合と
      # 同じ方法でテストを書くことができます。


    end
  end
end
