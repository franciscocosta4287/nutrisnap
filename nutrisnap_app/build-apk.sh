#!/bin/bash

echo "🔨 Gerando APK com Docker..."

# Usar imagem oficial do Flutter com Android SDK
docker run --rm \
  -v $(pwd):/app \
  -w /app \
  cirrusci/flutter:latest \
  /bin/bash -c "
    flutter clean && \
    flutter pub get && \
    flutter build apk --release
  "

echo "✅ APK gerado em: build/app/outputs/flutter-apk/app-release.apk"
