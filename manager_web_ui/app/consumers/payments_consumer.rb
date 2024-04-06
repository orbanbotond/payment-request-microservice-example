# frozen_string_literal: true

class PaymentsConsumer
  def consume(payload)
    command = event_to_command(payload)
    Rails.configuration.command_bus.(command) if command
  end

  def event_to_command(event_payload)
    case event_payload["type"]
    when "Payments::Events::PaymentRequested"
      data = event_payload["content"]["data"]
      Payments::Commands::RequestPayment.new( id: data["id"],
                                              amount: data["amount"],
                                              currency: data["currency"],
                                              description: data["description"],
                                            )
    end
  end
end
