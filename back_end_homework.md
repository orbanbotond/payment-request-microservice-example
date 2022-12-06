Create two simple Rails applications. Use events, carried over a message broker (eg. RabbitMQ, Kafka, Amazon SQS, etc.) for inter-app communication. It's OK to use libraries, whether it's just a client (eg. bunny) or a full-on message processing system (hutch, karafka, etc). We don't want this exercise to take too much of your time, be efficient with your choices. Each application needs to have its own, separate database.

Contractor app: a simple application for payment requests where a contractor can request a payment from their manager. A payment request consists of amount, currency, and text description. The contractor should be able to see all of their payment requests, whether they're pending, accepted, or rejected.
Manager app: a simple application that displays all payment requests submitted by the contractor. The manager can only accept or reject the payment request. The acceptance/rejection of payment request should be handled by the manager app publishing an event and the contractor app processing the event to update the status for the contractor.
These are the only requirements. If you feel something is unspecified, make your own decision.

For simplicity, don't worry about any of the following:

authentication: don't implement it, and for simplicity assume single-tenancy of each app (no user_id, no current_user)
state machines – don't worry about the elegant implementation of payment request states, just use a string/enum field
front-end: don't worry about the styles and markup: a plain-text app with links is fine
code duplication of event handling utilities: please don't spend your time extracting the common code to a third project to make it reusable – it's fine to have it duplicated in each app
What will be evaluated in this homework:

controller code that orchestrates everything – and all classes referenced by the controller code
event handling code – and all your classes called from the event handlers