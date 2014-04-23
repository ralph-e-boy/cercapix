//
//  CercaPixAnnotation.h
//  CercaPix
//  Annotation that adds a userInfo backing store containing original image info from feed.
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CercaPixAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSDictionary *imageInfo;

-(id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
