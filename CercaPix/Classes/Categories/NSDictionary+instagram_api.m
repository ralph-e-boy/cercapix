//
//  NSDictionary+instagram_api.m
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "NSDictionary+instagram_api.h"

#import "instagram_tags.h"

@interface NSDictionary()

// image location
@property (readwrite, assign) CGFloat latitude;
@property (readwrite, assign) CGFloat longitude;

// urls
@property (nonatomic,retain) NSString *thumbnailUrl;
@property (nonatomic,retain) NSString *lowResUrl;
@property (nonatomic,retain) NSString *standardResUrl;
@property (nonatomic,retain) NSString *filterName;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *assetType;
@property (nonatomic,retain) NSString *caption;

@end

@implementation NSDictionary (instagram_api)


#pragma mark Begin Convienience methods for json tag accesses

-(CGFloat) latitude
{
    CGFloat returnval = 0.0;
    id location = self[kLocationTag];
    
    if ( location )
    {
        id lat = location[kLatitudeTag];
        
        if( lat )
        {
            returnval = [lat floatValue];
            
        }
    }
    return returnval;
}


-(CGFloat) longitude
{
    CGFloat returnval = 0.0;
    id location = self[kLocationTag];
    
    if ( location )
    {
        id lat = location[kLongitudeTag];
        
        if( lat )
        {
            returnval = [lat floatValue];
        }
    }
    return returnval;
}

-(NSString*) thumbnailUrl
{
    return [self getImageUrl:kThumbnailTag];
}

-(NSString*) lowResUrl
{
    return [self getImageUrl:kLowResolutionTag];
}

-(NSString*) standardResUrl
{
    return [self getImageUrl:kStandardResolutionTag];
}

-(NSString*) getImageUrl:(NSString*) resolutionTag
{
    id url;
    
    id images = self[kImagesTag];
    assert([images isKindOfClass:[NSDictionary class]]);

    if( images)
    {
        id anIimage  = images[resolutionTag];
        assert([anIimage isKindOfClass:[NSDictionary class]]);
        if(anIimage)
        {
            url = [anIimage getStringFromTag:kURLTag];
        }
    }
    
    return url;
    
}

-(NSString*) filterName
{
    return [self getStringFromTag:kFilterTag];
}

-(NSString*) username
{
    id userObj = self[kUserTag];
    
    if(userObj)
    {
        return [userObj getStringFromTag:kUsernameTag];
    }
    return nil;
}

-(NSString*) assetType
{
    return [self getStringFromTag:kTypeTag];
}

-(NSString*) caption
{
    id cap = self[kCaptionTag];
    
    if( ! cap) return nil;
    
    //assert([cap isKindOfClass:[NSDictionary class]]);
    if( [cap isKindOfClass:[NSDictionary class]])
    {
        return [cap getStringFromTag:kTextTag];
    }
    return @"";
}

#pragma mark End convienience accessor methods

-(NSString*) getStringFromTag:(NSString *)tagName
{
    
    NSString *returnString=@"";
    id astring = self[tagName];
    
    if ([astring isKindOfClass:[NSString class]])
    {
         returnString = astring;
    }
    
    return returnString;
}


-(NSArray*) getImages
{
    return self[kDataTag];
}


@end
