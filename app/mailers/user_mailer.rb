class UserMailer < ApplicationMailer
  after_action  :set_delivery_options

  def welcome_email(order)
      @order = order
      # @url  = 'http://example.com/login'
      mail(to: @order.email, subject: "Thanks for your order #{@order.id}")
    end
  end

  private

    def set_delivery_options
        mail.delivery_method :test
    end

