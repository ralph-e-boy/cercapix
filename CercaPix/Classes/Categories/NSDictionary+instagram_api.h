//
//  NSDictionary+instagram_api.h
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

/**
 * Project-specific category on NSDictionary for simplified retrieval of
 * json data elements from a dictionary representing
 * instagram media search api results.
 *
 * Don't use this on any old NSDictionary you have laying around.
 *
 * It expects a result in the form of a NSDictionary, one that was
 * JSON-serialzed from media api search result feed matching the schema specified at:
 * http://instagram.com/developer/endpoints/media/#get_media_search (version v1 )
 * in the "response" section. In that example the first response entry "data"
 * is an array of the objects this category is looking for.
 *
 */

#import <Foundation/Foundation.h>


@interface NSDictionary (instagram_api)

// The following are convenience methods for accessing
// the instagram-specific fields in an NSDictionary

@property (nonatomic,readonly) CGFloat  latitude;
@property (nonatomic,readonly) CGFloat  longitude;
@property (nonatomic,readonly) NSString *thumbnailUrl;
@property (nonatomic,readonly) NSString *lowResUrl;
@property (nonatomic,readonly) NSString *standardResUrl;
@property (nonatomic,readonly) NSString *filterName;
@property (nonatomic,readonly) NSString *username;
@property (nonatomic,readonly) NSString *assetType;
@property (nonatomic,readonly) NSString *caption;


/**
 * retrieve an image url from a result entry
 * @param[in] resolutionTag - json tag specifying desired resolution
 * one of "low_resolution","thumbnail","standard_resolution"
 * constants for these defined in constants.h
 */

-(NSString*) getImageUrl:(NSString*) resolutionTag;

/** get an arbitrary json value by tag 
 *  this method -- used internally by the above
 *  convenience methods, but maybe useful in any case
 *  @param[in] tagName name of key to retrieve value for
 */
-(NSString*) getStringFromTag:(NSString*)tagName;

/**
 * return an array of json objects, representing a 
 * complete instagram api response list of image entries
 */
-(NSArray*) getImages;




@end
