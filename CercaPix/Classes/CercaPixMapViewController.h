//
//  CercaPixMapViewController.h
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CercaPixController.h"

@interface CercaPixMapViewController : UIViewController
           <MKMapViewDelegate,CercaPixControllerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mMapView;

@end
