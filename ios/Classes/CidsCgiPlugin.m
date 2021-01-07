#import "CidsCgiPlugin.h"
#if __has_include(<cids_cgi/cids_cgi-Swift.h>)
#import <cids_cgi/cids_cgi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cids_cgi-Swift.h"
#endif

@implementation CidsCgiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCidsCgiPlugin registerWithRegistrar:registrar];
}
@end
