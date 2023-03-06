class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    # メールアドレスの保存を許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name, :email])
    end
end
