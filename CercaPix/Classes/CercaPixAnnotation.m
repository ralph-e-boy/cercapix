//
//  CercaPixAnnotation.m
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "CercaPixAnnotation.h"

@interface CercaPixAnnotation()

@end

@implementation CercaPixAnnotation

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    
    self = [super init];
    if (self) {
        _coordinate = coord;
    }
    return self;
}


@end
