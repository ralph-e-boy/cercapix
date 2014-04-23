//
//  UIImageView+download.m
//  ImageDownloader
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "UIImageView+download.h"

@implementation UIImageView (download)


-(void) blackPlaceholder
{
    // draw a blank black image as a placeholder
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIColor blackColor]setFill];
    UIRectFill(self.bounds);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

}


-(void) downloadImageFromUrl:(NSString*)urlString
        withPlaceholderImage:(UIImage*) image
{
    self.image = image;
    [self _downloadImageFromUrl:urlString];
}

// basic implementation sets blank black placeholder
-(void) downloadImageFromUrl:(NSString*)urlString
{
    [self blackPlaceholder];
    [self _downloadImageFromUrl:urlString];
    
}

-(void) _downloadImageFromUrl:(NSString*)urlString
{
    
    static int retrycount = 0;
    
    if(retrycount > 1)
    {
        return;
    }
    
    
    // create url request with image string
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    
    // retrieve the remote image
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *_urlresponse,
                                               NSData *_responseData,
                                               NSError *_reqerror)
     {
         if(_reqerror == nil)
         {
             self.image = [UIImage imageWithData:_responseData];
         }
         else
         {
             retrycount++;
             
             // error, retry
             [self downloadImageFromUrl:urlString];
             
         }
     }];
    
    // otherwise leave blank black image
}


@end
