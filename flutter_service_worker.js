'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "af0f90d4342fe23dc47f8404422c5d01",
"index.html": "dbcb7c1f2c276d3ee8691de90f5d24ff",
"/": "dbcb7c1f2c276d3ee8691de90f5d24ff",
"main.dart.js_1.part.js": "edda2a309637d1e275e3b63009a1c4d8",
"favicon.png": "3e4b5fb787678b7e73ae295306c544a0",
"splash/img/light-2x.png": "393476575c605fe00c1bdc95067b0bc5",
"splash/img/dark-4x.png": "1bdd26c2f5b3afeec0309f11b41f19a4",
"splash/img/dark-3x.png": "be8556cf09baf8e5c767ca29f0adb879",
"splash/img/light-1x.png": "4dd7562e7f8c13a33bfaa294b8271b99",
"splash/img/dark-1x.png": "4dd7562e7f8c13a33bfaa294b8271b99",
"splash/img/dark-2x.png": "393476575c605fe00c1bdc95067b0bc5",
"splash/img/light-4x.png": "1bdd26c2f5b3afeec0309f11b41f19a4",
"splash/img/light-3x.png": "be8556cf09baf8e5c767ca29f0adb879",
"splash/style.css": "f3645f4a4bfc789ba6d2cfea954d5416",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"assets/fonts/MaterialIconsSelected.ttf": "b5cd11de6d654aa606b16d729de66e63",
"assets/AssetManifest.json": "46245946e6e849852611803f12924fa8",
"assets/FontManifest.json": "b1a85ccab31b56a833b509f50812db06",
"assets/assets/image_coming_soon.webp": "efdbd296c03825d543c9b570878f277c",
"assets/assets/taubman.webp": "5fe6e15e3e41c5119915b83109552bd5",
"assets/assets/hatcher.webp": "6846ce90d8e6dd731eb117080f01cd0c",
"assets/assets/fine_arts.webp": "d8aa5e20b4d8acd6f966a402bc1d3761",
"assets/assets/east_quad_blue_cafe.webp": "21b861c1810378680658fbd9c24f2757",
"assets/assets/music.webp": "62ce492c12d7e98029cc9ab47a6ebb3e",
"assets/assets/duderstadt.webp": "de60d6d3d5a0e31afbf101cbe854642d",
"assets/assets/east_quad.webp": "0c9355792a28543f66be15cf75ed4755",
"assets/assets/shapiro.webp": "d38f2424ee7341258f22b74db062005c",
"assets/assets/icon_512.png": "025dc9569d2df27b4d918485ef9de92c",
"assets/assets/east_quad_open_space.webp": "aa8a28193e5db9d969747d8c1ec6e404",
"assets/assets/hatcher_asia.webp": "f3b8e7171358c1a8a995e9cfb42ea526",
"icons/icon_maskable_192.png": "9a0c5bedeb1b07f2df2400d7d5eaac3f",
"icons/icon_maskable_512.png": "7cf31767214f117e8a98d3af6496518d",
"icons/icon_512.png": "025dc9569d2df27b4d918485ef9de92c",
"icons/icon_192.png": "003186b1991c03b27417c0d54224fd21",
"manifest.json": "798ee62dacce9ec5c70b7341456f9ab2",
"version.json": "a160186093edb8a028c8e579a78d2d67",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
