#!/usr/bin/env bash
set -e

FLUTTER_VERSION="stable"
FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone https://github.com/flutter/flutter.git \
    --branch "$FLUTTER_VERSION" --depth 1 "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

cd frontend

flutter --version
flutter pub get
flutter build web --release --dart-define=API_URL="$API_URL"
