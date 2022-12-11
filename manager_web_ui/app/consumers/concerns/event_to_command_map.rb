module EventToCommandMap
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