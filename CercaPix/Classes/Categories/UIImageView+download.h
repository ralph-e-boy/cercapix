//
//  UIImageView+download.h
//  An ImageDownloader category for UIImageView
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (download)

/**
 *
 * Asynchronously retrieve an image and
 * set UIImageView's member variable "image" to the downloaded image
 * @param[in] urlString A fully qualified url string 
 * representing the uri of the remote image
 *
 */

-(void) downloadImageFromUrl:(NSString*)urlString;

/**
 * Asynchronously retrieve an image and
 * set UIImageView's member variable "image" to the specified image
 * @param[in] urlString A fully qualified url string 
 * representing the uri of the remote image
 * @param[in] image - a UIImage to set as a placeholder while downloading
 *
 */

-(void) downloadImageFromUrl:(NSString*)urlString
        withPlaceholderImage:(UIImage*) image;

/**
 * set the imageview's image to a black filled 
 * drawn on the fly
 */
-(void) blackPlaceholder;

@end
