Hello Pilot :)
==============

These are the parties involved:
- payments: The payments core. Is a DDD payments core which allow payment request/reject/approval.
- contractor_web_ui: a web UI for contractors. It publishes the payment_requested event to the msg broker, handles the payment_accepted and payment_rejected events coming from the msg broker.
- manager_web_ui: a web UI for managers. It publishes the payment_accepted and payment_rejected events to the msg broker, and handles the payment_requested event coming from the msg broker.
- relational DB's for each web UI: contractor and manager for storing the local copy of the payment request aggregates.
- message broker Kafka for serving as message bus between the 2 web_uis

Process model:
==============
- There are 2 processes for each app. Karafka & rails web UI
- In addition to those there are the docker managed containers runing the zookeeper & kafka & postgresql processes.

Steps to launch:
----------------
- `docker compose up`
- `cd contractor_web_ui & bundle install & bundle exec db:setup & foreman start`
- open a new terminal app
- `cd contractor_web_ui & bundle install & bundle exec db:setup & foreman start`

Steps to play after launch:
---------------------------
- Step.0.1: open `http://localhost:3000`. Let's call this: `Tab1`. This incorporates the `Contractor Web UI`.
- Step.0.2: open a new browser tab and open `http://localhost:4000`. Let's call this: `Tab2`. This incorporates the `Manager Web UI`.
- Step.1: In `Tab1`: click `request new payment`. Then fill the form and `request a new payment`
- Step.2: Go to `Tab2`, then reload the page. The `payment request` added in the `Tab1` should appear in `Tab2`. Now reject/approve as You wish in `Tab2`
- Step.3: Go backIn `Tab1`. Reload the page. The `payment request` should have the same state as it was modified in the `Tab2` by the manager.