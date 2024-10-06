#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Valify-logo" asset catalog image resource.
static NSString * const ACImageNameValifyLogo AC_SWIFT_PRIVATE = @"Valify-logo";

#undef AC_SWIFT_PRIVATE