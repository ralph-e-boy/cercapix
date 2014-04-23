
//
//  CercaPixController.h
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.


/**
 *
 *    CercaPixController class -- A singleton class for handling:
 
 *     - methods for instagram api service calls
 *     - persisting data / datasource for collection view
 *     - storing application state
 *
 *    Use the accessor class method:
 *      [CercaPixController sharedInstance];
 *      to retrieve an instance of the singleton
 *
 *
 */

 

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Reachability.h"

#import "constants.h"

// Protocol used to return results of a search query back to view controller
@protocol CercaPixControllerDelegate <NSObject>
@optional

/**
 * Delegate method which is passed entire json data result list
 * @param[in] userInfo -- NSDictionary representation of the json response
 */
-(void) searchCompleted:(NSDictionary*) userInfo;

/**
 * Delegate method which is passed entire json data result list
 * @param[in] userInfo -- containing NSError object under key "error"
 */
-(void) searchFailed:(NSDictionary*) userInfo;



@end



@interface CercaPixController : NSObject

/// singleton accessor
+(instancetype)sharedInstance;

/// the users location, as reported by mapkit's location manager
@property (nonatomic,retain) CLLocation *searchOriginLocation;

/// the radius we are searching with
@property (readwrite,assign) CGFloat preferredSearchRadius;

/// an array of search results -
/// each item is in instagram json nsdictionary format
@property (nonatomic,retain) NSArray *searchResults;

/// the currently selected image's data
@property (nonatomic,retain) NSDictionary *selectedImage;

/// delegate -- used for callbacks for network operations
@property (nonatomic,weak) id<CercaPixControllerDelegate> delegate;


/// method to retrieve photos based on current settings
/// of radius and current user location
-(void) getNearbyPhotos;

/// get distance in km of a coordinate from the search origin
/// @param[in] coord - the coordinate to check against
-(CLLocationDistance) getPhotoDistance:(CLLocationCoordinate2D)coord;


@end


