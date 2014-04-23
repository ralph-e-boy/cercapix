//
//  constants.h
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//
//
//
//

#ifndef CercaPix_constants_h
#define CercaPix_constants_h



// Exported values for common use in app
// Values are generally set in constants.m

// starting search radius
FOUNDATION_EXPORT CGFloat const kDefaultSearchRadius;


// Instagram credentials
FOUNDATION_EXPORT NSString* const kInstagramClientId;
FOUNDATION_EXPORT NSString* const kInstagramClientSecret;

// service endpoints
FOUNDATION_EXPORT NSString* const kInstagramAPIServer;
FOUNDATION_EXPORT NSString* const kInstagramMediaSearchEndpoint;
FOUNDATION_EXPORT NSString* const kInstagramMediaInfoEndpoint;


// general tags for info dictionarys / json keys
FOUNDATION_EXPORT NSString* const kErrorTag;

//// instagram feed json key names
//FOUNDATION_EXPORT NSString* const kLocationTag;
//FOUNDATION_EXPORT NSString* const kLatitudeTag;
//FOUNDATION_EXPORT NSString* const kLongitudeTag;
//FOUNDATION_EXPORT NSString* const kImagesTag;
//FOUNDATION_EXPORT NSString* const kFilterTag;
//FOUNDATION_EXPORT NSString* const kUserTag;
//FOUNDATION_EXPORT NSString* const kTypeTag;
//FOUNDATION_EXPORT NSString* const kTextTag;
//FOUNDATION_EXPORT NSString* const kDataTag;
//FOUNDATION_EXPORT NSString* const kUsernameTag;
//FOUNDATION_EXPORT NSString* const kThumbnailTag;
//FOUNDATION_EXPORT NSString* const kLowResolutionTag;
//FOUNDATION_EXPORT NSString* const kStandardResolutionTag;
//FOUNDATION_EXPORT NSString* const kURLTag;
//FOUNDATION_EXPORT NSString* const kImageTag;
//FOUNDATION_EXPORT NSString* const kCaptionTag;


#define LOGV NSLog

typedef NSDictionary* InstagramSearchResult;



#endif
