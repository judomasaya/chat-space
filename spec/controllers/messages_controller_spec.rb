# メッセージ一覧を表示するアクションでテストすべきは以下の点です。

# ログインしている場合
# アクション内で定義しているインスタンス変数があるか
# 該当するビューが描画されているか

# ログインしていない場合
# 意図したビューにリダイレクトできているか
# 今回はログインをしているかどうかを条件に、contextを用いてテストをグループ分けしてみましょう。



require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  # 今回のテストで必要なインスタンスを生成する記述を行います。
  # 今回のように、複数のexampleで同一のインスタンスを使いたい場合、
  # letメソッドを利用することができます。
  # letメソッドは呼び出された際に初めて実行される、
  # 遅延評価という特徴を持っています。
  # 後述のbeforeメソッドが各exampleの実行前に毎回処理を行うのに対し、
  # letメソッドは初回の呼び出し時のみ実行されます。
  # 複数回行われる処理を一度の処理で実装できるため、
  # テストを高速にすることができます。また、一度実行された後は常に同じ値が返って来るため、
  # テストで使用したいオブジェクトの定義に適しています。



  describe '#index' do


    # ↓ログインしている場合のテストを記述

    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      # beforeブロックの内部に記述された処理は、各exampleが実行される直前に、
      # 毎回実行されます。beforeブロックに共通の処理をまとめることで、
      # コードの量が減り、読みやすいテストを書くことができます。

      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end
      # まず、アクション内で定義しているインスタンス変数が
      # あるかどうか確かめていきましょう。
      # インスタンス変数に代入されたオブジェクトは、
      # コントローラのassigns メソッド経由で参照できます。
      # @messageを参照したい場合、assigns(:message)と記述することができます。
      # @messageはMessage.newで定義された新しいMessageクラスのインスタンスです。
      # be_a_newマッチャを利用することで、
      #  対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか
      #  確かめることができます。
      #  今回の場合は、assigns(:message)がMessageクラスのインスタンスかつ
      #  未保存かどうかをチェックしています。


      
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
      # @groupはeqマッチャを利用して
      # assigns(:group)とgroupが同一であることを確かめることでテストできます。
      # 続いて、該当するビューが描画されているかどうかをテストしていきましょう。



      it 'renders index' do
        expect(response).to render_template :index
      end
    end
    # expectの引数にresponseを渡しています。
    # responseは、example内でリクエストが行われた後の
    # 遷移先のビューの情報を持つインスタンスです。 
    # render_templateマッチャは引数にアクション名を取り、
    # 引数で指定されたアクションがリクエストされた時に
    # 自動的に遷移するビューを返します。
    # この二つを合わせることによって、
    # example内でリクエストが行われた時の遷移先のビューが、
    # indexアクションのビューと同じかどうか確かめることができます。




    # ↓この中にログインしていない場合のテストを記述

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end
      # beforeブロックの内部に記述された処理は、各exampleが実行される直前に、
      # 毎回実行されます。beforeブロックに共通の処理をまとめることで、
      # コードの量が減り、読みやすいテストを書くことができます。

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end






# 問題7：messagesコントローラでメッセージを作成するアクションのテストを行いましょう。
# メッセージを作成するアクションでテストすべきは以下の点です。

# ログインしているかつ、保存に成功した場合
# メッセージの保存はできたのか
# 意図した画面に遷移しているか
# ログインしているが、保存に失敗した場合
# メッセージの保存は行われなかったか
# 意図したビューが描画されているか
# ログインしていない場合
# 意図した画面にリダイレクトできているか
# 今回は下記の条件に基づいて、contextでグループ分けをして行きましょう。

# ログインをしているかどうか
# メッセージの保存に成功したかどうか



describe '#create' do
  # letメソッドを用いてparamsを定義しています。
  # これは、擬似的にcreateアクションをリクエストする際に、
  # 引数として渡すためのものです。 
  # attributes_forはcreate、build同様FactoryBotによって
  # 定義されるメソッドで、オブジェクトを生成せずにハッシュを生成するという特徴があります。
  let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }


  # contextは、contextブロックの内部でネストさせることができます。
  # ネストさせることによって、ログインしている場合という条件の中で、
  # さらに保存に成功した場合・失敗した場合を条件にグループを分けることができました。

  context 'log in' do
  # この中にログインしている場合のテストを記述
    before do
      login user
    end

    # この中にメッセージの保存に成功した場合のテストを記述
    context 'can save' do
      subject {
        post :create,
        params: params
      }


      it 'count up message' do
        expect{ subject }.to change(Message, :count).by(1)
      end

      it 'redirects to group_messages_path' do
        subject
        expect(response).to redirect_to(group_messages_path(group))
      end
    end

          # この中にメッセージの保存に失敗した場合のテストを記述
    context 'can not save' do
      let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

      subject {
        post :create,
        params: invalid_params
      }

      it 'does not count up' do
        expect{ subject }.not_to change(Message, :count)
      end

      it 'renders index' do
        subject
        expect(response).to render_template :index
      end
    end
  end


      # この中にログインしていない場合のテストを記述
  context 'not log in' do

    it 'redirects to new_user_session_path' do
      post :create, params: params
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end