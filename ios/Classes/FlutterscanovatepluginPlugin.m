#import "FlutterscanovatepluginPlugin.h"
#if __has_include(<adotech_puntopay/adotech_puntopay-Swift.h>)
#import <adotech_puntopay/adotech_puntopay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "adotech_puntopay-Swift.h"
#endif

@implementation FlutterscanovatepluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterscanovatepluginPlugin registerWithRegistrar:registrar];
}
@end
