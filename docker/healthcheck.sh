#!/bin/bash

ELECTRUM_HOST="localhost"
ELECTRUM_PORT="50001"

# Use environment variable if available
: "${DISCORD_WEBHOOK_URL:?}"

# JSON-RPC payload with newline
PING_PAYLOAD='{"id":0,"method":"server.ping","params":[],"jsonrpc":"2.0"}'

echo "[INFO] Starting Electrum healthcheck..."
echo "[INFO] Sending ping to $ELECTRUM_HOST:$ELECTRUM_PORT"

# First attempt
RESPONSE=$(echo -e "$PING_PAYLOAD" | nc -w 3 "$ELECTRUM_HOST" "$ELECTRUM_PORT")
if [[ -z "$RESPONSE" ]]; then
  echo "[WARN] No response on first attempt. Retrying in 5 seconds..."
  sleep 5

  # Second attempt
  RESPONSE=$(echo -e "$PING_PAYLOAD" | nc -w 3 "$ELECTRUM_HOST" "$ELECTRUM_PORT")
  if [[ -z "$RESPONSE" ]]; then
    echo "[ERROR] Electrum server is unresponsive after second attempt."

    if [[ -z "$DISCORD_WEBHOOK_URL" ]]; then
      echo "[WARN] DISCORD_WEBHOOK_URL not set. Skipping Discord alert."
    else
      echo "[INFO] Sending alert to Discord..."
      DISCORD_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"⚠️ Electrum server is DOWN!\"}" \
         "$DISCORD_WEBHOOK_URL")

      if [[ "$DISCORD_RESPONSE" == "204" ]]; then
        echo "[INFO] Discord notification sent successfully."
      else
        echo "[ERROR] Failed to send Discord notification (HTTP $DISCORD_RESPONSE)"
      fi
    fi

    exit 1
  fi
fi

echo "[OK] Electrum server responded successfully."
exit 0