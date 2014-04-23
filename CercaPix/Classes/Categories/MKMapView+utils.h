//
//  MKMapView+utils.h
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (utils)

/**
 * Set the zoom level of the mapview 
 * by assigning a region with a span of the specified 
 * latitude and longitude deltas.
 *
 * @param[in] zoomLevel a float specifying the 
 * latitudeDelta and longitudeDelta of an MKRegion.span
 *
 */

-(void) setZoom:(CGFloat) zoomLevel;

/** 
 * Centers the map on the user location with a specified
 * radius being visible.
 * @param[in] nMeters the size of the radius in meters
 */
 
-(void) centerOnRadius:(CGFloat)nMeters;

@end
