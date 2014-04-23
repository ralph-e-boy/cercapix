#import "UIApplication+views.h"

@implementation UIApplication (views)

+(UIView*) topView
{
    UIView *topView = [[[[UIApplication sharedApplication]keyWindow]subviews] objectAtIndex:0];
    
    if (!topView)
    {
        UIWindow *topWin = [[UIApplication sharedApplication].windows lastObject];
        topView = [[topWin subviews] objectAtIndex:0];
    }
    
    return topView;
}

@end