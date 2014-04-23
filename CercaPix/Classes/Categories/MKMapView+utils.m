//
//  MKMapView+utils.m
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "MKMapView+utils.h"


// it's nice to inset the map a bit so the radius is *fully* visible
// if say, you have a circle showing the radius around the user location point
// multiplier sets margin of ~10% on each side --  (radius * 2 ) + .2
#define kCircleInsetMultiplier 2.2f

@implementation MKMapView (utils)

-(void) setZoom:(CGFloat)zoomLevel
{
    MKCoordinateRegion region = {0};
    region.center = self.userLocation.coordinate;
    region.span.latitudeDelta = zoomLevel;
    region.span.latitudeDelta = zoomLevel;
    [self setRegion:region animated:YES];
}

-(void) centerOnRadius:(CGFloat)nMeters
{
    
    if(nMeters > 0 && self.userLocation.location.coordinate.latitude > 0) // north pole edge case?
    {
    
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(
                                                        self.userLocation.location.coordinate,
                                                          nMeters*kCircleInsetMultiplier,
                                                          nMeters*kCircleInsetMultiplier
                                                          );
    [self setRegion:newRegion];
    }
}

@end
