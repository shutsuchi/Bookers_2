class RegistrationsController < Devise::RegistrationsController

  def create
    super
    @user = params[:user]
    ThankMailer.send_welcome_to_user(@user).deliver
  end

end
