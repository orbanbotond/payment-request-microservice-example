class PubSubCallbackController < ApplicationController
  protect_from_forgery with: :null_session

  def outside_event_have_happened
    return unless params[:topic] == 'payments'

    payload = params[:payload]
    PaymentsConsumer.new.consume(payload)
  end
end
