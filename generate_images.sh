#!/bin/bash

for input_file in images/buildings/*
do
  # Remove the "images/buildings/" dir prefix
  # Now left with for example "hatcher.jpeg"
  input_file_without_dir="${input_file:17}"
  # Convert original images like "hatcher.jpeg" to thumbnails named "hatcher.webp"
  # Aimed at saving storage space
  cwebp "$input_file" -o "assets/${input_file_without_dir%.*}.webp" -resize 200 0
done

for input_file in images/areas/*
do
  # Remove the "images/areas/" dir prefix
  # Now left with for example "hatcher_asia.jpeg"
  input_file_without_dir="${input_file:13}"
  # Convert original images like "hatcher_asia.jpeg" to "hatcher_asia.webp"
  # Aimed at saving storage space
  cwebp "$input_file" -o "assets/${input_file_without_dir%.*}.webp" -resize 400 0
done

cwebp "images/image_coming_soon.jpeg" -o "assets/image_coming_soon.webp" -resize 400 0
