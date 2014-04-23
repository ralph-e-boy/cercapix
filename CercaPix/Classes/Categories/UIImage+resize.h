//
//  UIImage+resize.h
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resize)

/**
 * Scale an image by a percentage, keeping aspect ratio 1:1
 * @param[in] percent - a float specifying percentage -- 1.0 = 100%;
 * @return a new scaled UIImage instance
 */
 
-(UIImage*) scaleByPercent:(CGFloat)percent;

@end
