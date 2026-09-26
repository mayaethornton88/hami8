HIGH PERFORMANCE UPDATE

What changed:
- Telegram callback buttons are acknowledged at update-ingestion time for normal callbacks, so the spinner does not wait behind business logic.
- Separate callback/message queues remain isolated so slow message work does not block buttons.
- Worker counts auto-scale from CPU count and remain bounded to protect the server.
- Telegram HTTP keep-alive pool increased to 256 connections.
- Callback/message queues increased to absorb traffic bursts without immediately dropping updates.
- Telegram getUpdates is restricted to message + callback_query updates.
- API timeout/retry backoff was tightened for faster recovery from transient failures.
- Existing service-filter and bot features are preserved.

Important:
100,000 concurrent users cannot be guaranteed by Python code alone. Telegram Bot API limits, server CPU/RAM/network, upstream SMS panels, and database throughput are hard limits. For true 100k-scale traffic, run multiple stateless bot workers behind a webhook/load-balancer architecture and move persistent data from JSON to PostgreSQL/Redis.

Server environment knobs:
TG_MESSAGE_WORKERS, TG_CALLBACK_WORKERS, TG_QUEUE_MAX, TG_CALLBACK_QUEUE_MAX, API_RETRIES, API_BACKOFF_BASE
