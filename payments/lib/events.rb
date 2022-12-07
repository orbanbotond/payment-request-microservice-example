module Payments
  module Events
    class PaymentRequested < Infra::Event
      attribute :id, Infra::Types::Strict::String
      attribute :amount, Infra::Types::Strict::Integer
      attribute :currency, Infra::Types::Strict::String
      attribute :description, Infra::Types::Strict::String
    end

    class PaymentRejected < Infra::Event
      attribute :id, Infra::Types::Strict::String
      attribute :cause_of_rejection, Infra::Types::Strict::String
    end

    class PaymentApproved < Infra::Event
      attribute :id, Infra::Types::Strict::String
    end
  end
end
