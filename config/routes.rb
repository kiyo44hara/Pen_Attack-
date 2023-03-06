Rails.application.routes.draw do
  
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
    get '/' => 'homes#top'

  end
end

end
