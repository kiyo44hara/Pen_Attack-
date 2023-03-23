class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
    # メールアドレスの保存を許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name, :email])
    end

    # 管理者でログイン後の遷移先を、会員一覧に指定しています
    # ゲストメンバーの遷移先は、sessions_controllerにて記載
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(Admin)
        admin_path
      else
        root_path
      end
    end

    # 会員と管理者のログアウト先の画面を、それぞれのログイン画面に設定しています。
    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :member
        new_member_session_path
      elsif resource_or_scope == :admin
        new_admin_session_path
      else
        new_member_registration_path
      end
    end

end
