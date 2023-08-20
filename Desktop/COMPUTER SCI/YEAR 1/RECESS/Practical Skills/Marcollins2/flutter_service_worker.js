'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "85aa332f1979cfe5e29ff4f0cf857399",
"assets/AssetManifest.json": "a78cd50bd3decfbdc8c7246346538c8c",
"assets/assets/icons/culture.png": "4fdfde78da418762cefd176717afa1e6",
"assets/assets/icons/dress.png": "c179cf11e3cdcc5e5ffe790a7acf1316",
"assets/assets/icons/muslim.png": "c00df13bd7e146ec61a651d514e30478",
"assets/assets/images/skin_tone.jpg": "e79a5a3a0cef4104dbd6744918e18662",
"assets/assets/models/mobilenet_v1_1.0_224.tflite": "570a9615104b5d8afac870fc5dec88f1",
"assets/assets/models/mobilenet_v1_1.0_224.txt": "ecd16958caaca618d74987df32db3e65",
"assets/assets/models/posenet_mv1_075_float_from_checkpoints.tflite": "e0c83d992292731a3f2dfe387d1470a6",
"assets/assets/models/ssd_mobilenet.tflite": "efbf596715eec74b5d5cea0e9dff573b",
"assets/assets/models/ssd_mobilenet.txt": "820ccd3a3ce5e663a56c25e8e34f49cd",
"assets/assets/models/yolov2_tiny.tflite": "b40966316ade0b3644f22b9e921e634b",
"assets/assets/models/yolov2_tiny.txt": "4caf6834300c8b2ff19964b36e54d637",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "ecc3ebcd2cb88d47405deb84e0d3e2f0",
"assets/images/img1.jpg": "14115789e31a052b748454e5d543aa28",
"assets/images/img10.jpg": "4383ff438f28853aba169fe202bbf62e",
"assets/images/img12.jpg": "d0656b2961b797a7254ae6ea0b7d182b",
"assets/images/img13.jpg": "50d750aa5c69b893aad842aa38985d3f",
"assets/images/img15.jpg": "4f5baa3beeea044d55cddc0527d13b1c",
"assets/images/img16.jpg": "4396f8003884d6af26d01c6984a00df7",
"assets/images/img17.jpg": "d6ef21855cac54a50ef5547561dd9bce",
"assets/images/img18.jpg": "f9ce85f7cc9fcaf6d4ad0b0527eb0b8c",
"assets/images/img19.jpg": "cfe8b51130f44a72917ac1fc687968af",
"assets/images/img2.jpg": "7ce72ee75e498cab7683a1087bc5befc",
"assets/images/img20.jpg": "12c2f3973d23453485a477760e2d8584",
"assets/images/img21.jpg": "84c8976f83b7e9efe82b787a51a4151b",
"assets/images/img22.jpg": "7236b6de31190e9cc16223d0beb4165c",
"assets/images/img23.jpg": "349c4cc9eb59a7f8da17bc3f94481a92",
"assets/images/img26.jpg": "529bcc9d0f7cc032af9ad32b6e9ec468",
"assets/images/img27.jpg": "1849688370ce7da42c14a2a5dfedf691",
"assets/images/img28.jpg": "5dab098298ffd9d9e22c327811a0c912",
"assets/images/img3.jpg": "7fb3b1dfc2a5e49cbb30aa27c2ca6d87",
"assets/images/img31.jpg": "560aa6908f391c51c796020b394a5ab6",
"assets/images/img4.jpg": "bf9703893610ca446b37f8cd74ee05aa",
"assets/images/img41.jpg": "3d176d22cc74ca13d16e29682d944357",
"assets/images/img42.jpg": "1088dfbff0a2b9c3a3d5500198b445e3",
"assets/images/img43.jpg": "501115bfbef819f4a3fa8a2172e84441",
"assets/images/img44.jpg": "921d8ec73c13a032177f9d7eb255adba",
"assets/images/img45.jpg": "46591d2286549c81eab8a6e3fe05f7e7",
"assets/images/img46.jpg": "451d61aacff178bc40712f8fe20d3f6f",
"assets/images/img47.jpg": "b93b33f577c33a6145fb27a31401effa",
"assets/images/img48.jpg": "77aa065f3f3217cd32b85406b76bc4fe",
"assets/images/img49.jpg": "5cdf3a60d08398b4a966ea712e5c0a70",
"assets/images/img50.jpg": "ab097f52d3c091f5b801d0b100e84d4f",
"assets/images/img51.jpg": "334fe9af5d57cca3587efc65f497617f",
"assets/images/img52.jpg": "a8bb095fe0f107034e1c776e80995731",
"assets/images/img53.jpg": "434f1af3e957f8b5251fff44727879f7",
"assets/images/img54.jpg": "b08c21f81d1dfb243a6f641bcef48fe1",
"assets/images/img55.jpg": "1310e0d21ad76f4d72d2a62f07a948a1",
"assets/images/img56.jpg": "3e516b9958b297e00f2ae2e5a6096eed",
"assets/images/img6.jpg": "54ef70680fb4dabf0605fa1caa03a98a",
"assets/images/img8.jpg": "fbad465de782ceec669cfa1ac3aa3361",
"assets/NOTICES": "e4d775315be819ddc4cf403855d37255",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f37bfa5a92ee1cc8e44c8c21f09a0dac",
"/": "f37bfa5a92ee1cc8e44c8c21f09a0dac",
"main.dart.js": "84c5f173dcf50a0c1bc928d80b4b7c6b",
"manifest.json": "4e2eb2316ca187e8beb84e28c2876dec",
"version.json": "ed060502604e9208cd1bee9facd4872d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
