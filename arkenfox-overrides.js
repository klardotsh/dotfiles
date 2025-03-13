// OVERRIDE: allow geolocation where allowed
user_pref("geo.provider.use_geoclue", true); // 0202

// OVERRIDE: allow session restore
user_pref("browser.startup.page", 3); // 0102
  // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
user_pref("privacy.clearOnShutdown.history", false); // 2811 FF127 or lower
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128+

// 2820 optional to match when you use settings>Cookies and Site Data>Clear Data
user_pref("privacy.clearSiteData.historyFormDataAndDownloads", false); // FF128+

// 2830 optional to match when you use Ctrl-Shift-Del (settings>History>Custom Settings>Clear History)
// user_pref("privacy.cpd.history", false); // FF127 or lower
// user_pref("privacy.clearHistory.historyFormDataAndDownloads", false); // FF128+

// OVERRIDE: download to XDG_DOWNLOADS_DIR, always
user_pref("browser.download.useDownloadDir", true); // 2651

// OVERRIDE: allow WebGL, I use CanvasBlocker to get "some" privacy back
user_pref("webgl.disabled", false); // 4520

// OVERRIDE: do not start in private browsing
user_pref("browser.privatebrowsing.autostart", false); // 5001

// OVERRIDE: allow memory cache (dynamically sized)
user_pref("browser.cache.memory.enable", true); // 5002
user_pref("browser.cache.memory.capacity", -1); // 5002

// OVERRIDE: favicons in history/bookmarks
user_pref("browser.chrome.site_icons", true); // 5006

// OVERRIDE: suggest open pages and bookmarks in urlbar
user_pref("browser.urlbar.suggest.bookmark", true); // 5010
user_pref("browser.urlbar.suggest.openpage", true); // 5010

// OVERRIDE: re-enable SVG, ASMJS, WASM
user_pref("svg.disabled", false); // 5502
user_pref("javascript.options.asmjs", true); // 5504
user_pref("javascript.options.wasm", true); // 5506
