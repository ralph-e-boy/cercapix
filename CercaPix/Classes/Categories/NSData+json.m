//
//  NSData+json.m
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "NSData+json.h"

@implementation NSData (json)

-(NSMutableDictionary*) json
{
    
    NSMutableDictionary *_jsonResponse = nil;
    NSError *e = nil;
    
    _jsonResponse = [NSJSONSerialization JSONObjectWithData:self
                                                    options:NSJSONReadingMutableContainers
                                                      error:&e];

    if ( e != nil)
    {
        return nil;
    }
    
    return _jsonResponse;
    
}

@end
