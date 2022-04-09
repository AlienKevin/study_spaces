#!/bin/bash

pngquant assets/Icon-512.png --force --quality 65-80 --output assets/Icon-512.png
pngquant assets/Icon-maskable-512.png --force --quality 65-80 --output assets/Icon-maskable-512.png

### Clean and rebuild flutter ###
flutter clean
flutter pub get

### Generate Web icons ###
rm -rf web/icons/*

# Copy over Icon-512.png
cp assets/Icon-512.png web/icons/Icon-512.png
# Generate Icon-192.png
convert assets/Icon-512.png -resize 192x192 web/icons/Icon-192.png
pngquant web/icons/Icon-192.png --force --quality 65-80 --output web/icons/Icon-192.png

# Copy over Icon-512.png
cp assets/Icon-maskable-512.png web/icons/Icon-maskable-512.png
# Generate Icon-192.png
convert assets/Icon-maskable-512.png -resize 192x192 web/icons/Icon-maskable-192.png
pngquant web/icons/Icon-maskable-192.png --force --quality 65-80 --output web/icons/Icon-maskable-192.png

### Generate iOS and Android icons ###
flutter pub run flutter_launcher_icons:main -f pubspec.yaml

#### Generate splash screen for Web, Android, and iOS ###
flutter pub run flutter_native_splash:create
