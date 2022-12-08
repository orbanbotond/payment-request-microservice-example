# frozen_string_literal: true

# Example consumer that prints messages payloads
class PaymentsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      # TODO Add Deserialize:
      # propagate the command to the command bus

      puts message.payload
    end
  end

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
