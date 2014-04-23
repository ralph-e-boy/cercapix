#import <UIKit/UIKit.h>

// Category to retrieve the application's top-most UIView
// which is a subview of UIWindow

@interface UIApplication (views)

+(UIView*) topView;

@end
