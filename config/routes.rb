# Rails.application.routes.draw do
#   devise_for :users
#   root "groups#index"
#   resources :users, only: [:index, :edit, :update]
#   resources :groups, only: [:new, :create, :edit, :update] do
#     resources :messages, only: [:index, :create]
#  end
# end


# messagesのルーティングはgroupsにネストされているため、
# group_idを含んだパスを生成します。
# そのため、getメソッドの引数として、
# params: { group_id: group.id }を渡しています。

Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  # :indexを追記
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]

    
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end


# namespace :ディレクトリ名 do ~ endと囲む形でルーティングを記述すると、
#   そのディレクトリ内のコントローラのアクションを指定できます。
#   /groups/:id/api/messagesというパスでリクエストを受け付け、
#   api/messages_controller.rbのindexアクションが動くようになります。