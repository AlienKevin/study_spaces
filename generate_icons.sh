#!/bin/bash

### Clear old web icons ###
rm -rf web/icons/*

pngquant images/icon_512.png --force --quality 65-80 --output assets/icon_512.png
pngquant images/icon_maskable_512.png --force --quality 65-80 --output web/icons/icon_maskable_512.png

### Clean and rebuild flutter ###
flutter clean
flutter pub get

### Generate Web icons ###

# Copy over icon_512.png
cp assets/icon_512.png web/icons/icon_512.png
# Generate icon_192.png
convert assets/icon_512.png -resize 192x192 web/icons/icon_192.png
pngquant web/icons/icon_192.png --force --quality 65-80 --output web/icons/icon_192.png

# icon_512.png is already in web/icons after compression
# Generate icon_192.png
convert web/icons/icon_maskable_512.png -resize 192x192 web/icons/icon_maskable_192.png
pngquant web/icons/icon_maskable_192.png --force --quality 65-80 --output web/icons/icon_maskable_192.png

### Generate iOS and Android icons ###
flutter pub run flutter_launcher_icons:main -f pubspec.yaml

#### Generate splash screen for Web, Android, and iOS ###
flutter pub run flutter_native_splash:create
