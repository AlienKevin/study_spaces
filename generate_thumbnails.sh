#!/bin/bash

for input_file in images/*
do
  # Remove the "images/" dir prefix
  # Now left with for example "hatcher.jpeg"
  input_file_without_dir="${input_file:7}"
  # Convert original images like "hatcher.jpeg" to thumbnails named "hatcher.webp"
  # Aimed at saving storage space
  cwebp "$input_file" -o "assets/${input_file_without_dir%.*}.webp" -resize 200 0
done
