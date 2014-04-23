//
//  CercaPixTests.m
//  CercaPixTests
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CercaPixController.h"
#import "NSString+urls.h"

@interface CercaPixTests : XCTestCase

@end

@implementation CercaPixTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}
- (void)testStringQueryParams
{
    NSDictionary *params = @{@"foo": @"bar",@"baz":@"bat"};
    NSString *querystring = [NSString queryStringWithParams:params];
    XCTAssertEqualObjects(querystring, @"?foo=bar&baz=bat",@"bad format");
}



@end
