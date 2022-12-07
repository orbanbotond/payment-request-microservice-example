module Payments
  class PaymentRequestReport < ApplicationRecord
    class Configuration
      def call(cqrs)
        @cqrs = cqrs

        subscribe_and_link_to_stream(
          ->(event) { requested(event) },
          [Payments::Events::PaymentRequested]
        )
        subscribe_and_link_to_stream(
          ->(event) { rejected(event) },
          [Payments::Events::PaymentRejected]
        )
        subscribe_and_link_to_stream(
          ->(event) { approved(event) },
          [Payments::Events::PaymentApproved]
        )
      end

      private

      def subscribe_and_link_to_stream(handler, events)
        link_and_handle = ->(event) do
          link_to_stream(event)
          handler.call(event)
        end
        subscribe(link_and_handle, events)
      end

      def link_to_stream(event)
        @cqrs.link_event_to_stream(event, "Report$all")
      end

      def subscribe(handler, events)
        @cqrs.subscribe(handler, events)
      end

      def rejected(event)
        request = PaymentRequestReport.find event.data.fetch(:id)
        request.update(state: :rejected, cause_of_rejection: event.data.fetch(:cause_of_rejection))
      end

      def approved(event)
        request = PaymentRequestReport.find event.data.fetch(:id)
        request.update(state: :approved)
      end

      def requested(event)
        PaymentRequestReport.create id: event.data.fetch(:id),
                               currency: event.data.fetch(:currency),
                               amount: event.data.fetch(:amount),
                               description: event.data.fetch(:description),
                               state: :requested
      end
    end

    self.table_name = "payment_request_reports"
    # fields:
    # - id
    # - amount
    # - currency
    # - description
    # - cause_of_rejection
    # - state: Requested, Approved, Rejected
  end
end
