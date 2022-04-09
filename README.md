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

## Generate App and Web Icons Locally

1. Install PNG compression tool pngquant
   `brew install pngquant`

2. Install ImageMagick tool
   `brew install imagemagick`

3. Put the new icons (must be 512x512) in as `assets/Icon-512.png` and `assets/Icon-maskable-512.png`

4. See this tutorial on [maskable icons](https://web.dev/maskable-icon/). You should also test your
   maskable icons using [this online tool](https://maskable.app/).

5. Run `generate_icons.sh`. You can only run this script *once* on the new icons!
   Running multiple times may *increase* the size of the icons because of repeated redundant compression.

## \[Deprecated Method\] Generate App and Web Icons with Web Tools

<details>
<summary>See More</summary>

### Generate Web Icons

Icon location: `web/icons/Icon-192.png` and `web/icons/Icon-512.png`

Tool: https://appiconmaker.co/Home

You can generate and download `Icon-192.png` and `Icon-512.png` under the Android section

### Test PWA Maskable Icons

Icon location: `web/icons/Icon-maskable-192.png` and `web/icons/Icon-maskable-512.png`

Tool: https://maskable.app/

Tutorial: https://web.dev/maskable-icon/

### Generate Favicon

Icon location: `web/favicon.png`

Tool: https://realfavicongenerator.net/

### Update Splash Icon

Icon location: `assets/splash.png`

Copy `Icon-512.png` to the above location and rename it to `splash.png`.

</details>