class CreatePaymentRequestReport < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_request_reports do |t|
      t.decimal :amount
      t.string :currency
      t.string :description
      t.string :cause_of_rejection
      t.string :state

      t.timestamps
    end
  end
end
