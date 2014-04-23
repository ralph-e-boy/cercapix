//
//  UIImage+resize.m
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "UIImage+resize.h"

@implementation UIImage (resize)

-(UIImage*) scaleByPercent:(CGFloat)percent
{
    CIImage *ciImage =  [CIImage imageWithCGImage:self.CGImage];
    CIFilter *resizeFilter = [CIFilter filterWithName:@"CILanczosScaleTransform"];
    [resizeFilter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputAspectRatio"];
    [resizeFilter setValue:ciImage forKey:@"inputImage"];
    [resizeFilter setValue:[NSNumber numberWithFloat:percent] forKey:@"inputScale"];
    return [UIImage imageWithCIImage:[resizeFilter outputImage]];
}

@end
