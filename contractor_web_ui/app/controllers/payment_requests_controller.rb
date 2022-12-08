class PaymentRequestsController < ApplicationController
  def index
    @payment_requests = Payments::PaymentRequestReport.all
  end
end