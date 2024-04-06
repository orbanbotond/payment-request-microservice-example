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

        authorization = "test-contractor:test-contractor-password"
        headers = { 'Content-Type' => 'application/json; charset=utf-8', "Authorization" => "Basic " + Base64::encode64(authorization) }
        url = "http://localhost:3001/api/v1/topics/payments/publish"

        RestClient::Request.execute(
          method: :post,
          url: url,
          headers: headers,
          payload: { payload: payload }.to_json
        )
      end
    end
  end
end
