#import "FlutterscanovatepluginPlugin.h"
#if __has_include(<puntored_plugin_flutter/puntored_plugin_flutter-Swift.h>)
#import <puntored_plugin_flutter/puntored_plugin_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "puntored_plugin_flutter-Swift.h"
#endif

@implementation FlutterscanovatepluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterscanovatepluginPlugin registerWithRegistrar:registrar];
}
@end
