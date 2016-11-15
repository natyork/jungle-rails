class UserMailer < ApplicationMailer
  after_action  :set_delivery_options
                :log_and_clear_emails

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

    def log_and_clear_emails
        mail.deliveries.each { |d| Rails.logger.debug(d) }
        mail.deliveries.clear
    end
