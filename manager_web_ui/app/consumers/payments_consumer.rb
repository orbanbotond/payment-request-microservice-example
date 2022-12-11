# frozen_string_literal: true

class PaymentsConsumer < ApplicationConsumer
  include EventToCommandMap

  def consume
    messages.each do |message|
      payload = message.payload
      command = event_to_command(payload)
      Rails.configuration.command_bus.(command) if command
    end
  end

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
