# Study Spaces

Find study spaces at the University of Michigan, Ann Arbor

## Generate Study Space Thumbnails

Run the `generate_thumbnails.sh` to convert jpeg images in `images/` folder to webp images. The script
then outputs the webp images to `thumbnails/`

## Generate Selected Material Icons

Icon tree shaking is still not supported in Flutter Web as of Apr 6, 2022. You can track this feature
on [this Flutter GitHub issue](https://github.com/flutter/flutter/issues/57181).
Without tree shaking, the full `MaterialIcons-Regular.otf` weighs 1.5MB without compression and still
weighs a whopping 515KB after compression by server. Downloading this full otf file slows down initial
page load speed so we need to manually package only those material icons used in this project.
We rely on fluttericon.com to generate the custom icon font for us. To add or change the list
of icons packaged:

1. Go to fluttericon.com
2. Drag and drop the `fluttericon-config.json` to the website
3. Search for new icons to include or drag and drop custom SVGs to the website.
4. Download a zip from the website
5. Replace the `fonts/MaterialIconsSelected.ttf` and `lib/MaterialIconsSelected.dart` with the new files in the zip folder

### Note

1. fluttericon.com only accepts `<path>` in SVG, so newer versions of material icons may need manual
   conversion to work on fluttericon.com.
2. Reference this guide for more details: https://medium.com/codechai/how-to-use-custom-icons-in-flutter-834a079d977