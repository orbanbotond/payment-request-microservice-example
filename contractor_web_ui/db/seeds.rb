# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

request_payment_0 = Payments::Commands::RequestPayment.new(id: SecureRandom.uuid, amount: 0, currency: 'EUR', description: 'Feature')
request_payment_1 = Payments::Commands::RequestPayment.new(id: SecureRandom.uuid, amount: 1, currency: 'EUR', description: 'Feature')
approve_payment_1 = Payments::Commands::ApprovePayment.new(id: request_payment_1.id)
request_payment_2 = Payments::Commands::RequestPayment.new(id: SecureRandom.uuid, amount: 2, currency: 'EUR', description: 'Feature')
reject_payment_2 = Payments::Commands::RejectPayment.new(id: request_payment_2.id, cause_of_rejection: 'test')

Rails.configuration.command_bus.(request_payment_0)
Rails.configuration.command_bus.(request_payment_1)
Rails.configuration.command_bus.(approve_payment_1)
Rails.configuration.command_bus.(request_payment_2)
Rails.configuration.command_bus.(reject_payment_2)
