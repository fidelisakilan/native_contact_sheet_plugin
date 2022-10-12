#import "ContactSheetPlugin.h"
#if __has_include(<contact_sheet/contact_sheet-Swift.h>)
#import <contact_sheet/contact_sheet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "contact_sheet-Swift.h"
#endif

@implementation ContactSheetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftContactSheetPlugin registerWithRegistrar:registrar];
}
@end
