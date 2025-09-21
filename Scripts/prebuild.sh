#!/usr/bin/env bash
set -euo pipefail

echo "Running prebuild checks..."
if [ ! -f "App/Resources/ContentBlocker.json" ]; then
  echo "warning: ContentBlocker.json missing; web content will not be filtered" >&2
fi
