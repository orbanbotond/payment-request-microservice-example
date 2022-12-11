module Payments
  class RequestForm
    include ActiveModel::Model

    attr_accessor :amount
    attr_accessor :currency
    attr_accessor :description

    validates :amount, presence: true,
                       numericality: { greater_than_or_equal_to: 1 }
    validates :currency, presence: true
    validates :description, presence: true
  end
end
