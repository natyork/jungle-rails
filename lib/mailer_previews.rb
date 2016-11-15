class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(Order.first)
  end
end