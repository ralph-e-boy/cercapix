//
//  NSString+urls.m
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "NSString+urls.h"

@implementation NSString (urls)

 

+(NSString*) queryStringWithParams:(NSDictionary*) params
{
    
    if(!params)
    {
        return nil;
    }
    
    if([params allKeys].count > 0)
    {
        NSMutableString *parameterstring=[NSMutableString stringWithString:@"?"];
        
        [[params allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [parameterstring appendString:[NSString stringWithFormat:@"%@=%@",obj,params[obj]]];
            
            if( idx < [params allKeys].count - 1)
            {
                [parameterstring appendString:@"&"];
            }
            
        }];
        
        return [parameterstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    }
    
    return nil;
}

@end
