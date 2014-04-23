//
//  UIView+effects.h
//  CercaPix
//
//  Created by kramden.com on 4/22/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//



#import <UIKit/UIKit.h>

// some handy defines
#define kDefaultShadowAmount        12.0f
#define kDefaultShadowOpacity       0.4f
#define kDefaultShadowOffset        4.0f
#define kDefaultCornerRadius        12.0f 


/**
 * UIView category for visual effects such as fade, etc
 *
 */

@interface UIView (effects)

/**
 * Fade in a UIVIew to alpha 1.0 from alpha 0.0
 * sets hidden = NO;
 */
 
-(void) show;

/**
 * Fade out a UIVIew to alpha 1.0 from alpha 0.0
 * sets hidden = YES;
 */
-(void) hide;

/**
 * Add a fuzzy shadow to a UIView
 */
-(void)addShadow;


/**
 * Add a smaller fuzzy shadow to a UIView
 */
-(void)addSmallShadow;


@end
