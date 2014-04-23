//
//  NSString+urls.h
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (urls)

/**
 *
 *  Create a query-string style string using
 *
 *  @param[in] params -- a key-value pair dictionary of
 *  query parameters to be appended to the created string.
 *  Example ?foo=bar&baz=bat
 *  @return an NSString instance of the 
 *  format "?key1=value1&key2=value2.."
 *
 */

+(NSString*) queryStringWithParams:(NSDictionary*) params;

@end
