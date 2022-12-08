module Payments
  module Commands
    class RequestPayment < Infra::Command
      attribute :id, Infra::Types::Strict::String
      attribute :amount, Infra::Types::Coercible::Integer
      attribute :currency, Infra::Types::Strict::String
      attribute :description, Infra::Types::Strict::String
    end

    class RejectPayment < Infra::Command
      attribute :id, Infra::Types::Strict::String
      attribute :cause_of_rejection, Infra::Types::Strict::String
    end

    class ApprovePayment < Infra::Command
      attribute :id, Infra::Types::Strict::String
    end
  end
end
