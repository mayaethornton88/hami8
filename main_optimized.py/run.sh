#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"

export PYTHONUNBUFFERED=1
# High-concurrency defaults; override these in the server environment when needed.
export TG_QUEUE_MAX="${TG_QUEUE_MAX:-10000}"
export TG_CALLBACK_QUEUE_MAX="${TG_CALLBACK_QUEUE_MAX:-5000}"
export API_RETRIES="${API_RETRIES:-3}"
export API_BACKOFF_BASE="${API_BACKOFF_BASE:-0.35}"
export BOT_RESTART_DELAY="${BOT_RESTART_DELAY:-5}"

mkdir -p logs

while true; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Telegram bot..." | tee -a logs/supervisor.log
    python3 main.py
    status=$?

    if [ "$status" -eq 130 ] || [ "$status" -eq 143 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Bot stopped by signal (exit $status)." | tee -a logs/supervisor.log
        exit "$status"
    fi

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Bot exited (exit $status). Restarting in ${BOT_RESTART_DELAY}s..." | tee -a logs/supervisor.log
    sleep "$BOT_RESTART_DELAY"
done
