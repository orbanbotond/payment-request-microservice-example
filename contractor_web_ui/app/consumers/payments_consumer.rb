# frozen_string_literal: true

class PaymentsConsumer
  def consume(payload)
    command = event_to_command(payload)
    Rails.configuration.command_bus.(command) if command
  end

  def event_to_command(event_payload)
    case event_payload["type"]
    when "Payments::Events::PaymentRejected"
      data = event_payload["content"]["data"]
      Payments::Commands::RejectPayment.new( id: data["id"],
                                             cause_of_rejection: data["cause_of_rejection"],
                                            )
    when "Payments::Events::PaymentApproved"
      data = event_payload["content"]["data"]
      Payments::Commands::ApprovePayment.new( id: data["id"],
                                            )
    end
  end
end
