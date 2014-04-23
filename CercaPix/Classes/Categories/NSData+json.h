//
//  NSData+json.h
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (json)

/**
 * return a json-serialized object converted from an nsdata
 *
 */

-(NSMutableDictionary*) json;

@end
