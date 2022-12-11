# frozen_string_literal: true

class PaymentsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload
      command = event_to_command(payload)
      Rails.configuration.command_bus.(command) if command
    end
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

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
