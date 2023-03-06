class Members::SessionsController < Devise::SessionsController

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: 'guestmemberでログインしました！'
  end

end
