#!/usr/bin/env sh
# Creates local, ignored configuration files after cloning. Existing files stay untouched.
set -eu
cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

for pair in '.env.example:.env' '.env.telegram.example:.env.telegram'; do
  template=${pair%%:*}
  target=${pair#*:}
  if [ -e "$target" ]; then
    printf '%s already exists; leaving it unchanged.\n' "$target"
  else
    cp "$template" "$target"
    printf 'Created %s.\n' "$target"
  fi
done

printf '\nAdd your API keys to .env and your Telegram bot token to .env.telegram.\n'
printf 'These files are ignored by Git and must not be committed.\n'
