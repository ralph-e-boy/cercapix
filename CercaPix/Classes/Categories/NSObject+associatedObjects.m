//
//  NSObject+associatedObjects.m
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+associatedObjects.h"

@implementation NSObject (associatedObjects)

-(void) associateObject:(id)value forKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

-(id) getAssociateObjectForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
