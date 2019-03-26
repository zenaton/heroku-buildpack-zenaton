#!/usr/bin/env bash

# Setup Locations
AGENT_DIR="$HOME/.zenaton"
AGENT_CLI="$AGENT_DIR/zenaton"

env

if [ -z "$ZENATON_APP_ID" ]; then
  echo "ZENATON_APP_ID environment variable not set. Run: heroku config:add ZENATON_APP_ID=<your App ID>"
  DISABLE_ZENATON_AGENT=1
fi

if [ -z "$ZENATON_API_TOKEN" ]; then
  echo "ZENATON_API_TOKEN environment variable not set. Run: heroku config:add ZENATON_API_TOKEN=<your Api Token>"
  DISABLE_ZENATON_AGENT=1
fi

if [ -z "$ZENATON_APP_ENV" ]; then
  echo "ZENATON_APP_ENV environment variable not set. Run: heroku config:add ZENATON_APP_ENV=<your Api Token>"
  DISABLE_ZENATON_AGENT=1
fi

# Execute the final run logic.
if [ -n "$DISABLE_ZENATON_AGENT" ]; then
  echo "The Zenaton Agent has been disabled. Unset the DISABLE_ZENATON_AGENT or set missing environment variables."
else
  # Run the Zenaton Agent
  echo "Starting Zenaton Agent"
  bash -c "$AGENT_CLI start"

  # Listen to the environment
  echo "Start listening to application $ZENATON_APP_ID using environment $ZENATON_APP_ENV"
  bash -c "$AGENT_CLI listen $ZENATON_LISTEN_ARGS"
fi
