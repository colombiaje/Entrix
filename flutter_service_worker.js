'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "474451bebfc372f78eed54dd2bda85b6",
".git/config": "40b8bbbdf55bf75fabae1703d95fb60b",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "6dcda8882dcf190a0019efb6d6503562",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "2576fc24c209d6620cca64a80ebd6864",
".git/logs/refs/heads/gh-pages": "2576fc24c209d6620cca64a80ebd6864",
".git/logs/refs/remotes/origin/gh-pages": "e660a4a3f39efeb0e39b3a4979f566bf",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/07/cc3b4a614883e9dc8280c6c230de84bc2d3368": "68f06d966fab41a1ddd42ce6ca1a2e98",
".git/objects/0d/6dba54a6679d11c1b784091adcdf2900658db7": "9f0e2344084b3fa23dd2aaaa1f5ef711",
".git/objects/0f/e4dda1b10164b6447e5c72336b3e116257a539": "9fa9b246fbb3025c2ddbc1fd8fc68334",
".git/objects/19/8c6afedcb749dafac0070a0a47049419dd3d6e": "41fc4f95cc97a28e8119b7f1df2a84ac",
".git/objects/25/ccec822415993d4d8df0de3dd334634f16a3d9": "b2b0276358f2ac0601d2b76a8fabf283",
".git/objects/34/4bbd37b6edfa0252bf5099304cb83455c439c1": "7fe17b83b0ebc86eddcd76c88f877c77",
".git/objects/35/117ac602655bc0fd5e1b6311716be58f99889b": "a44a4d10d1be2fdb73012a1c3174897e",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4d/a3a100a489bb540966ae11cef2ef4b08490fee": "6b083b3faa296a6731b4dff560cdc898",
".git/objects/54/0ad8f77241a6475fddb760837d0949cfc466f1": "dc84bc9139ac1454c1b89a04e3c4dfe0",
".git/objects/63/781f30e192816e303af0f05b0c9b96718526a4": "b76055393f07f68f87d6ebb9b368e779",
".git/objects/67/b6182df5eea0a23b3bf31439099782bb74415c": "bea978c5bc6cffb8b2a5baceb723e9ae",
".git/objects/68/61ddefd9af45965751cb6b2807e785d6ffbb7e": "0f7ccf7ad2fdc4ac6742a39e68788de0",
".git/objects/69/dd618354fa4dade8a26e0fd18f5e87dd079236": "8cc17911af57a5f6dc0b9ee255bb1a93",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8f/0b7ba40650dc8403cef89eb535492c1f231015": "b029b304c3d44c25da999f87f00272a8",
".git/objects/8f/e7af5a3e840b75b70e59c3ffda1b58e84a5a1c": "e3695ae5742d7e56a9c696f82745288d",
".git/objects/95/3294ea97a48b43bca77b9d520b9f0eafb50db5": "860db4c6c367dd5ec2541fdecd7b3dc8",
".git/objects/96/e92993689a06fc4ea8b816859dd9f49de1133c": "bfb6b2845e95582e475b7786211ef39e",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/9d/6edf92fc809a6962ba3ec89cb437031dd9b369": "7b87898c805ed564593ef6e4041a20ba",
".git/objects/9d/9980454f8c7bbdca8da708a9a5924f33f9cf35": "b341342fa11b8096bc3e7567024ab68a",
".git/objects/b2/a0cb8015eae061601305cbe392e93d108ab21d": "4d79df95fb97d364275649c990c71457",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/960e2b16a17acaac15aad9aeee3e17d0f4d0d0": "eb2bf0ff3e09d1870cfa5eabbd441e1f",
".git/objects/b8/c0abe77604f1c44ec666cfffc8e401e8dcad4e": "3cf05a0085a0b782c6f36e767602dcb8",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c5/f40240b824245d6a52f9881391a96ca180f1fd": "ecac456b34e6a38bced3c91b0f889e2c",
".git/objects/c7/0ce0b59be89eac3cd4a9d6ebdd3fd46a2f950b": "cede7dbf5767bd25e24454bacc72cdb9",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/e7/9bd831bec6592a53a20170a4d10f0571201d17": "d5b2db566a8f313d167e5b2aa1edb178",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/refs/heads/gh-pages": "f0cfae98bcc1ad069310e418441d74ce",
".git/refs/remotes/origin/gh-pages": "f0cfae98bcc1ad069310e418441d74ce",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0100e3fba49b3afdf936b2079f945875",
"assets/NOTICES": "2135ff87c8040901625847a84662470c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "b7494490812ea0b4c2cbb3969019be96",
"canvaskit/canvaskit.wasm": "1febcf3fdbbfb632728ab3902c386b44",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "9961e966e98a802d73942d48b15b86e7",
"canvaskit/chromium/canvaskit.wasm": "407d7dd73b05e38e5cafa7b789e22feb",
"canvaskit/skwasm.js": "ede049bc1ed3a36d9fff776ee552e414",
"canvaskit/skwasm.js.symbols": "6c749208f75e81d9628fa894d73bfbdc",
"canvaskit/skwasm.wasm": "a2021418f5cb63318cbe273e2e75f877",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f89db28227ec48576c4247890b4446f8",
"flutter_bootstrap.js": "d0b222d0a2fe76603ed32cddb6a9ffca",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9d6389d4b2688f0ae7890d615809b57e",
"/": "9d6389d4b2688f0ae7890d615809b57e",
"main.dart.js": "07f4f03535f89c288c415aefc06133a7",
"manifest.json": "0672831537c41a8990d517b76930504d",
"version.json": "981f89345b1da8af63e05545105dedd6"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
