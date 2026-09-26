PIX SMS PENAL - STABLE SERVER v4

Updates in this version:
- Preserves the existing stable server, Mini App, PIX SMS PENAL ON/OFF and Premium Emoji skip features.
- Remembers the service/category from which each number was allocated (for local stock and configured API panels).
- OTP group forwarding now shows the original number category/service (for example: Facebook) above the forwarded OTP line.
- Category mapping is persisted in the local database and cleaned for numbers no longer in active stock.
- Existing bounded worker, retry/backoff, RAM protection, watchdog and crash logging features are preserved.

Run:
  bash run.sh

Logs:
  cat logs/bot.log
