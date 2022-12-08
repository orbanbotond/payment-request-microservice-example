# frozen_string_literal: true

class PaymentsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload
      command = event_to_command(payload)
      Rails.configuration.command_bus.(command) if command
    rescue
      puts "The id didn't match"
      puts $!
    end
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

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
