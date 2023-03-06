Rails.application.routes.draw do

  # 管理者用URL
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    # サインアップ、パスワードの変更を排除
  sessions: "admin/sessions"
}

  # 顧客用URL
  devise_for :members, skip: [:passwords], controllers: {
    # パスワードの変更を排除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    # 管理者トップページ(会員一覧・会員退会機能)
    get '/' => 'members#index'
    resources :members, only: [:update]
    # ↑の記述があってるかわからない。トップ画面のアクションとして成立するのか確認する。またリーダブルコードとして修正するならどうするのが良いかも確認。
    
    # 管理者側検索画面
    get 'searches' => 'searches#search', as:'search'
    
    # 管理者側投稿機能に、コメント機能をネストさせています
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end
  
  scope module: :public do
    root to: "homes#top"
    
    # 顧客側検索機能画面
    get 'searches' => 'searches#search', as:'search'
    
    # 顧客側の投稿機能に、応援、コメント機能をネストさせています
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :yells, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    
    # 顧客側のマイページ
    resources :members, only: [:show, :edit, :update, :destroy]
  end

end
