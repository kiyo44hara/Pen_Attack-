Rails.application.routes.draw do
  
  # 顧客用URL
  devise_for :members, skip: [:passwords], controllers: {
    # パスワードの変更を排除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用URL
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    # サインアップ、パスワードの変更を排除
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
