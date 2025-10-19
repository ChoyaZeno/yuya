/// Asset paths for Yuya plugin
library;

/// Path to the AOT compiled plugin snapshot
const String kYuyaPluginAotPath = 'packages/yuya/assets/yuya_plugin.aot';

/// Get the asset path for the AOT plugin
String getYuyaPluginPath() {
  return kYuyaPluginAotPath;
}
