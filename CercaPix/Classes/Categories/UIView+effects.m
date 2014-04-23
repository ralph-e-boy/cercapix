//
//  UIView+effects.m
//  CercaPix
//
//  Created by kramden.com on 4/22/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "UIView+effects.h"

@implementation UIView (effects)

-(void) show
{
    self.alpha = 0.0;
    self.hidden = NO;
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void) hide
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         self.hidden = YES;
                         
                     }];
}


// some day one will be able to set this stuff in ib.
// until then ... categories
- (void)addShadow
{
    // visual drawing improvements on status message
    self.layer.cornerRadius = kDefaultCornerRadius;
    self.layer.shadowOffset = CGSizeMake(kDefaultShadowOffset, kDefaultShadowOffset);
    self.layer.shadowOpacity = kDefaultShadowOpacity;
    self.layer.shadowRadius = kDefaultShadowAmount;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}



/// just halve every value in previous addShadow
- (void)addSmallShadow
{
    self.layer.cornerRadius = kDefaultCornerRadius/2;
    self.layer.shadowOffset = CGSizeMake(kDefaultShadowOffset/2, kDefaultShadowOffset/2);
    self.layer.shadowOpacity = kDefaultShadowOpacity;
    self.layer.shadowRadius = 0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}



@end
