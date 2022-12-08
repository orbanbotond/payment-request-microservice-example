class PaymentRequestsController < ApplicationController

  def index
    @payment_requests = Payments::PaymentRequestToReview.all
  end

  def approve
    command_bus.(Payments::Commands::ApprovePayment.new(id: params[:id]))

    redirect_to payment_requests_path
  end

  def reject
    command_bus.(Payments::Commands::RejectPayment.new(id: params[:id], cause_of_rejection: 'Just because... I have not written any UI for the reason'))

    redirect_to payment_requests_path
  end

private

  def command_bus
    Rails.configuration.command_bus
  end
end