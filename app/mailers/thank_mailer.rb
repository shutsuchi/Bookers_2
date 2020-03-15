class ThankMailer < ActionMailer::Base
  default from: 'hogehoge@sample.com'

  def send_welcome_to_user(user)
    @user = user
    @url = ''
    mail(
      subject: '会員登録完了しました',
      to: @user["email"]
    ) do |format|
      format.text
    end
  end
end
