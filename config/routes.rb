Rails.application.routes.draw do

  # 管理者側
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    # サインアップ、パスワードの変更を排除
  sessions: "admin/sessions"
}

  # 顧客側
  devise_for :members, skip: [:passwords], controllers: {
    # パスワードの変更を排除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_scope :member do
    # ゲストメンバーでのサインイン
    post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
    # 新規登録エラー後、更新をかけるとエラーが起きる不具合解消
    get '/members', to: redirect("/members/sign_up")
  end



  namespace :admin do
    # 管理者トップページ(会員一覧・会員退会機能)
    get '/' => 'members#index'
    resources :members, only: [:update]

    # 通報機能(一覧・詳細・更新)
    resources :reports, only: [:index, :show, :update]

    # 管理者側検索画面
    get 'searches' => 'searches#search', as:'search'

    # 管理者側投稿機能に、コメント機能をネストさせています
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:update, :destroy]
    end
  end

  scope module: :public do
    root 'homes#top'
    # 顧客側検索機能画面
    get 'searches' => 'searches#search', as:'search'

    # 顧客側の投稿機能に、応援、コメント機能をネストさせています
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resource :yells, only: [:show, :create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end


    # 顧客側のマイページ
    resources :members, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      resource :reports, only: [:new, :create]
      get 'relationships/follow' => 'relationships#follow', as:'follow'
      get 'relationships/follower' => 'relationships#follower', as:'follower'
      member do
      get :yells  # 応援一覧ページ
      end
    end

    # 顧客側：お問い合わせ
    resource :contacts, only: [:new, :create]
    # エラー出た状態での更新後、ルートエラー対策
    get '/contacts', to: redirect("contacts/new")

  end #public scope end

end
