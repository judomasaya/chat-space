Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only: [:edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
 end
end


# messagesのルーティングはgroupsにネストされているため、
# group_idを含んだパスを生成します。
# そのため、getメソッドの引数として、
# params: { group_id: group.id }を渡しています。