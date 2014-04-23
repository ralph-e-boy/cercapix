//
//  CercaPixControllerTests.m
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CercaPixController.h"

#import "NSData+json.h"
#import "NSDictionary+instagram_api.h"
#import "instagram_tags.h"


/** 
 * test cases for parsing json data from instagram api.
 * and NSDictionary category access methods
 *
 */


@interface CercaPixControllerTests : XCTestCase
{
    // string sample data from instagram media search feed
    NSString *feedResult;
    NSDictionary *jsonResults;
    NSDictionary *json;
    NSString *jsonString;
}




@end

@implementation CercaPixControllerTests

- (void)setUp
{
    
    [self parseJson];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateMediaSearchServiceURL
{
   // NSString *foo = [[CercaPixController sharedInstance] createServiceURLString];
}

-(void) parseJson
{
    //
    
    NSError *ioerror = nil;
    
    // load a json feed
    NSString *path = [[NSBundle mainBundle] pathForResource:@"search" ofType:@"json"];
    
    jsonString = [NSString stringWithContentsOfFile:path
                                           encoding:NSUTF8StringEncoding error:&ioerror];
    
    NSData *data = [NSData dataWithData:[jsonString
                                         dataUsingEncoding:NSUTF8StringEncoding]];
    
    // all results
    jsonResults = [data json];
    
    
    // single entry
    json = [[jsonResults getImages]firstObject];
    
    XCTAssertTrue([json isKindOfClass:[NSDictionary class]],
                  @"-json result set did not return a valid NSDictionary entry for first object");
    
}

-(void) testJsonValid
{
    XCTAssertNotNil(json, @"json parse returned nil");
    XCTAssertTrue([json isKindOfClass:[NSDictionary class]],
                  @"-json did not return a valid NSDictionary");
}

-(void) testSingleJsonEntryValid
{
    XCTAssertNotNil(json, @"json parse returned nil");
    XCTAssertTrue([json isKindOfClass:[NSDictionary class]],
                  @"-json did not return a valid NSDictionary entry");
}

-(void) testLatitude
{
	CGFloat result = [json latitude];
	XCTAssertTrue(fpclassify(result)!=FP_NAN,
                  @"could not retrieve value for key %@",kLatitudeTag);
}

-(void) testLongitude
{
	CGFloat result = [json longitude];
	XCTAssertTrue(fpclassify(result)!=FP_NAN,
                  @"could not retrieve value for key %@",kLongitudeTag);
}

-(void) testThumbnailUrl
{
	NSString *result = [json thumbnailUrl];
    NSString *compare = @"http://distilleryimage4.s3.amazonaws.com/30e9c9e8caf611e3981d0002c99b2cb8_5.jpg";
	XCTAssertTrue([result isEqualToString:compare],
                  @"could not retrieve value for key %@ (%@)",kThumbnailTag,result);
}

-(void) testLowResUrl
{
	NSString *result = [json lowResUrl];
    NSString *compare = @"http://distilleryimage4.s3.amazonaws.com/30e9c9e8caf611e3981d0002c99b2cb8_6.jpg";
	XCTAssertTrue([result isEqualToString:compare],
                  @"could not retrieve value for key %@ (%@)",kLowResolutionTag,result);
}

-(void) testStandardResUrl
{
	NSString *result = [json standardResUrl];
    NSString *compare = @"http://distilleryimage4.s3.amazonaws.com/30e9c9e8caf611e3981d0002c99b2cb8_8.jpg";
    
	XCTAssertTrue([result isEqualToString:compare],
                  @"could not retrieve value for key %@ (%@)",kStandardResolutionTag,result);
}


-(void) testFilterName
{
	NSString *result = [json filterName];
    NSString *compare = @"Rise";
	XCTAssertTrue([result isEqualToString:compare],
                  @"could not retrieve value for key %@ (%@)",kFilterTag,result);
}

-(void) testUsername
{
	NSString *result = [json username];
    NSString *compare = @"summer56";
	XCTAssertTrue([result isEqualToString:compare],@"could not retrieve value for key %@",kUsernameTag);
}

-(void) testAssetType
{
	NSString *result = [json assetType];
    NSString *compare = @"image";
	XCTAssertTrue([result isEqualToString:compare],@"could not retrieve value for key %@",kTypeTag);
}

-(void) testCaption
{
	NSString *result = [json caption];
    NSString *compare = @"First place of World Famous\u2764\ufe0f#supreme";
	XCTAssertTrue([result isEqualToString:compare],@"could not retrieve value for key %@",kCaptionTag);
}


- (void)testGetPixNearMe
{
    [[CercaPixController sharedInstance] getNearbyPhotos];
}

@end
