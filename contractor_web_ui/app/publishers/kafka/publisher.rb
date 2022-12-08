module Kafka
  class Publisher
    def call(cqrs)
      @cqrs = cqrs

      @cqrs.subscribe(kafka_publisher, [Payments::Events::PaymentRequested])
    end

    private

    def kafka_publisher
      ->(event) do
        payload = { type: event.class , content: event.as_json }.to_json
        Karafka.producer.produce_sync(topic: 'payments', payload: payload)
      end
    end
  end
end
