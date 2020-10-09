#import "AesCtrPlugin.h"
#if __has_include(<aes_ctr/aes_ctr-Swift.h>)
#import <aes_ctr/aes_ctr-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "aes_ctr-Swift.h"
#endif

@implementation AesCtrPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAesCtrPlugin registerWithRegistrar:registrar];
}
@end
