require_relative 'config/environment'

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('payments', durable: true)

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

begin
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    payload = JSON.parse(body)
    command = event_to_command(payload) rescue nil
    Rails.configuration.command_bus.(command) if command

    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close

  exit(0)
end