class PaymentRequestsController < ApplicationController
  def new
    @payment_request_form = Payments::Request.new
  end

  def create
    @payment_request_form = Payments::Request.new payment_params
    if @payment_request_form.valid?
      command_bus.(Payments::Commands::RequestPayment.new(id: SecureRandom.uuid,
                                                          amount: @payment_request_form.amount,
                                                          currency: @payment_request_form.currency,
                                                          description: @payment_request_form.description))
      redirect_to payment_requests_path
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def index
    @payment_requests = Payments::PaymentRequestReport.all
  end

private

  def command_bus
    Rails.configuration.command_bus
  end

  def payment_params
    request.parameters[:payments_request]
  end
end