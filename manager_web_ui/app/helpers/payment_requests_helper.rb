module PaymentRequestsHelper
  def state_info(payment_request)
    return payment_request.state unless payment_request.state == 'rejected'

    "#{payment_request.state} Cause: #{payment_request.cause_of_rejection.first(15)}"
  end
end
