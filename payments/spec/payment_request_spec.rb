require_relative 'spec_helper'

RSpec.describe Payments::PaymentRequest do
  include Payments::TestPlumbing

  describe 'commands handling' do
    let(:request_payment) { Payments::Commands::RequestPayment.new(id: id, amount: amount, currency: currency, description: description) }
    let(:currency) { 'EUR' }
    let(:description) { 'Feature had been shipped' }
    let(:amount) { 1 }
    let(:id) { SecureRandom.uuid }

    describe 'request payment' do
      subject(:payment_requested) { Payments::Events::PaymentRequested.new( data: { id: id, amount: amount, currency: currency, description: description } )}

      it 'publishes the Requested event' do
        expect {
          run_command(request_payment)
        }.to publish_in_stream("Payments::PaymentRequest$#{id}", payment_requested)
      end
    end

    describe 'reject payment' do
      let(:cause_of_rejection) { 'Feature is not yet complete' }
      let(:reject_payment) { Payments::Commands::RejectPayment.new(id: id, cause_of_rejection: cause_of_rejection) }

      subject(:payment_rejected) { Payments::Events::PaymentRejected.new( data: { id: id, cause_of_rejection: cause_of_rejection } )}

      it 'publishes the Rejected event' do
        run_commands(request_payment)

        expect {
          run_command(reject_payment)
        }.to publish_in_stream("Payments::PaymentRequest$#{id}", payment_rejected)
      end
    end

    describe 'approve payment' do
      let(:approve_payment) { Payments::Commands::ApprovePayment.new(id: id) }

      subject(:payment_approved) { Payments::Events::PaymentApproved.new( data: { id: id } )}

      it 'publishes the Approved event' do
        run_commands(request_payment)

        expect {
          run_command(approve_payment)
        }.to publish_in_stream("Payments::PaymentRequest$#{id}", payment_approved)
      end
    end
  end
end
