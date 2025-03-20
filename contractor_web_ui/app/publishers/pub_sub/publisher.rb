module PubSub
  class Publisher
    def call(cqrs)
      @cqrs = cqrs

      @cqrs.subscribe(pub_sub_publisher, [Payments::Events::PaymentRequested])
    end

    private

    def pub_sub_publisher
      ->(event) do
        payload = { type: event.class , content: event.as_json }

        authorization = "contractor_key"
        headers = { 'Content-Type' => 'application/json; charset=utf-8', "Authorization" => "Bearer #{authorization}" }
        url = "http://localhost:3001/pubsub/topics/1/messages"

        RestClient::Request.execute(
          method: :post,
          url: url,
          headers: headers,
          payload: { message: {payload: payload} }.to_json
        )
      end
    end
  end
end
