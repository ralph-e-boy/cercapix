//
//  NSObject+associatedObjects.h
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (associatedObjects)


/**
 * set an associated object 
 * @param[in] value - the object to be associated 
 * @param[in] key - the name of the object to be added
 */
- (void)associateObject:(id)value forKey:(void *)key;

/**
 * retrieve an associated object indexed by the specified key
 * @param[in] key - the name of the object to retrieve
 */
- (id)getAssociateObjectForKey:(void *)key;

@end
