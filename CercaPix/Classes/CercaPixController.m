//
//  CercaPixController.m
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import "CercaPixController.h"
#import "NSString+urls.h"
#import "NSDictionary+instagram_api.h"
#import "constants.h"
#import "StatusMessageView.h"
#import "UIApplication+views.h"
#import "UIView+effects.h"

@interface CercaPixController()
{
    
    // private copy of current set of photos near me
    NSDictionary *mPixNearMeJSONData;
    

    
}

/// creates a search service url
-(NSString*) createServiceURLString;

@end

@implementation CercaPixController

+(instancetype)sharedInstance
{
    static dispatch_once_t cp_singleton_once_token;
    static CercaPixController *sharedInstance;
    dispatch_once(&cp_singleton_once_token, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.preferredSearchRadius = kDefaultSearchRadius;
    });
    
    
    return sharedInstance;
}


-(NSString*) createServiceURLString
{
    NSDictionary *params = @{
                                @"distance":@(self.preferredSearchRadius),
                                @"lat":@(self.searchOriginLocation.coordinate.latitude),
                                @"lng":@(self.searchOriginLocation.coordinate.longitude),
                                @"client_id":kInstagramClientId
                           };
    
    NSString *querystring = [NSString queryStringWithParams:params];
    
    return [NSString stringWithFormat:@"%@/%@%@",kInstagramAPIServer,kInstagramMediaSearchEndpoint,querystring];
}

-(void) getNearbyPhotos
{
    
    NSURL *url = [NSURL URLWithString:[self createServiceURLString]];
    NSMutableURLRequest *request = [NSMutableURLRequest  requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *_urlresponse, NSData *_responseData, NSError *_reqerror) {
                               
                              NSHTTPURLResponse *http_resp = (NSHTTPURLResponse *)_urlresponse;

                              if( _reqerror == nil)
                              {
                               
                               if([http_resp statusCode] == 200)
                               {
                                   
                                   NSMutableDictionary *_jsonResponse = nil;
                                   NSError *jsonParseError = nil;
                                   _jsonResponse = [NSJSONSerialization JSONObjectWithData:_responseData
                                                                                  options:NSJSONReadingMutableContainers
                                                                                    error:&jsonParseError];
                                   
                                   if( jsonParseError != nil) // json parse error or other error
                                   {
                                       // TODO delegate error message
                                       
                                       if( [self.delegate respondsToSelector:@selector(searchFailed:)])
                                       {
                                           // send the json data back to the delegate
                                           NSDictionary *userInfo = @{kErrorTag:jsonParseError};
                                           [self.delegate searchFailed:userInfo];
                                       }
                                       
                                       return ;
                                   }
                                   else // only replace local copy of data if json parse was successful
                                   {
                                       
                                       // this is raw data
                                       mPixNearMeJSONData = _jsonResponse;
                                       self.searchResults = [mPixNearMeJSONData getImages];
                                   }
                                   
                                   // at this point the info was retreived
                                   // call our delegate to return the data back to the view controller
                                   if( [self.delegate respondsToSelector:@selector(searchCompleted:)])
                                   {
                                       // send the json data back to the delegate
                                       [self.delegate searchCompleted:mPixNearMeJSONData];
                                   }
                                   
                                   
                               } /// status code 200
                                  
                              } /// no error on async request
                               
                               
                           }];
 
    
}

-(CLLocationDistance) getPhotoDistance:(CLLocationCoordinate2D)coord
{
    // alas, the instagram api says it gives you distance. it is not true!
    // so instead calculate distance here
    CLLocation *annotationLocation = [[CLLocation alloc]
                                      initWithLatitude:coord.latitude longitude:coord.longitude];
    
    CLLocationDistance distance = [[CercaPixController sharedInstance].searchOriginLocation
                                   distanceFromLocation:annotationLocation];
    
    CLLocationDistance distanceInKm = distance/1000;
    
    return distanceInKm;
}




@end
