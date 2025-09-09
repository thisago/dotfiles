user_pref("places.history.enabled", true);
user_pref("browser.startup.homepage", "about:serviceworkers");

// Keep history
// See: https://github.com/arkenfox/user.js/issues/1971#issuecomment-3065016884
user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.cpd.history", false);
user_pref("privacy.clearOnShutdown.history", false); // v1 clearOnShutdown
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs2", false); // keeps v1 clearOnShutdown used until v2 is stable
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // v2 clearOnShutdown
user_pref("privacy.clearOnShutdown_v2.siteSettings", false);
