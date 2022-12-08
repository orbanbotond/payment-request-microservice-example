class CreatePaymentRequestToReview < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :payment_requests_to_review, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.decimal :amount
      t.string :currency
      t.string :description
      t.string :cause_of_rejection
      t.string :state

      t.timestamps
    end
  end
end
