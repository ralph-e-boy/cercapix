//
//  CercaPixMapViewController.m
//  CercaPix
//
//  Created by kramden.com on 4/19/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//


#import "CercaPixMapViewController.h"
#import "CercaPixController.h"
#import "CercaPixGalleryViewController.h"
#import "CercaPixAnnotation.h"
#import "MKMapView+utils.h"
#import "CercaPixAnnotationView.h"
#import "NSDictionary+instagram_api.h"
#import "UIColor+unixcolors.h"
#import "UIImageView+download.h"
#import "UIImage+resize.h"
#import "UIView+effects.h"
#import "StatusMessageView.h"
#import "constants.h"

@interface CercaPixMapViewController ()<UIGestureRecognizerDelegate>
{
    // private variables
    MKCircle *mMapOverlayCircle;
    CercaPixAnnotation *selectedAnnotation;
    
    // used to display temporary status messages
    StatusMessageView *mStatusMessageView;
    NSTimer *mMessageTimer;

}

// IB actions

/// callback for slider value (on drag)
- (IBAction)sliderValueChanged:(UISlider *)sender;
/// callback for slider touch up inside and outside
- (IBAction)sliderTouchEnded:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mKmLabel;
@property (weak, nonatomic) IBOutlet UIView *mStatusBarView;
@property (weak, nonatomic) IBOutlet UILabel *mStatusLabel;
@property (weak, nonatomic) IBOutlet UIView *mSliderView;

-(void) showDetails:(id) sender;

-(void) statusMessage:(NSString*)text timeOut:(CGFloat) timeout;

/// set up the map
- (void)initMapAndUI;

@end

@implementation CercaPixMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMapAndUI];
    
    
    /**
     TODO:  show an intro screen for first time usage, with help screen 
     and a (reliable) network checker, as testing has shown flaky cell connection
     is not reported back to user and photos just don't show up.
    NSString *tag = @"userDidSeeIntro4";
    BOOL userDidSeeIntro = [[[NSUserDefaults standardUserDefaults]objectForKey:tag] boolValue];
    userDidSeeIntro = NO;
    if(! userDidSeeIntro)
    {
        [self performSegueWithIdentifier:@"intro" sender:self];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:TRUE] forKey:tag];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
     
     */
    

}

- (void)initMapAndUI
{
    // handle map UI delegate with self
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
    self.mMapView.delegate = self;
    
    // monitor location + follow
    [self.mMapView.userLocation addObserver:self
                                 forKeyPath:@"location"
                                    options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                    context:NULL];
    
    [self.mMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    // register as the main controller's delegate
    // for api service calls
    [CercaPixController sharedInstance].delegate= self;
    
    // add a gesture recognizer to detect single taps on mapview
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleTapGesture:)];
    
    tapgesture.numberOfTouchesRequired = 1;
    tapgesture.numberOfTapsRequired = 1;
    tapgesture.delegate = self;
    
    [self.mMapView addGestureRecognizer:tapgesture];
    
    // if this method was called, then we got a fix,
    // so tell the user.
    [self statusMessage:@"Getting a fix on your location..." timeOut:10.0f];
    
    [_mSliderView addShadow];
    [_mStatusBarView addShadow];
        
    });
        
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if([gestureRecognizer.view isKindOfClass:[MKMapView class]])
    {
        return YES;
    }
    return NO;
    
    
}

#pragma mark gesture recognizer

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}


/**
 * Delegate method implementation:
 * tag images from the raw json feed 
 * 
 *
 */
-(void) searchCompleted:(NSDictionary *)userInfo
{
    
    // images retrieved from a search are queried for info to make
    // an annotation + callout info
    
    
    NSString *message = nil;
    int nfound = [userInfo getImages].count;
    if( nfound == 0)
    {
        message = [NSString stringWithFormat:@"Didn't find any images near you within a %@ radius",
          _mKmLabel.text];
        
    }
    else if (nfound == 1)
    {
        message = [NSString stringWithFormat:@"Found one image near you within a %@ radius",
          _mKmLabel.text];
        
    }
    else
    {
        message = [NSString stringWithFormat:@"Found %d items near you.",
                             [userInfo getImages].count];
    }
    
    
    [self statusMessage:message  timeOut:1.3f];
    
    [[userInfo getImages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        // each result here is a "feed object" from instagram (media search api)
        NSDictionary *result = (NSDictionary*) obj;
        
        // using the *project specific* NSDictionary category "instagram_api"
        // we can retrieve the values for latitude and longitude
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(result.latitude, result.longitude);
        
        CercaPixAnnotation *annotation = [[CercaPixAnnotation alloc]initWithLocation:coord];
        
        // store the search resulit image info in the annotation
        annotation.imageInfo = result;
        
        // set some info on the image detail callout
        NSString *typeOfImage = @"Image";
        if ( ![result.assetType isEqualToString:@"image"])
        {
            typeOfImage = @"Video";
        }
        
        
        CLLocationDistance distanceInKm = [[CercaPixController sharedInstance]
                                           getPhotoDistance:coord];
        
        annotation.title = [NSString stringWithFormat:@"%d %@: %@",
                            idx+1,typeOfImage, result.filterName];
        
        annotation.subtitle = [NSString stringWithFormat:@"by %@ : %.2f km",
                               result.username,distanceInKm];
        
        [self.mMapView addAnnotation:annotation];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

/// To prepare for this segue we'll pass the value of
/// the selected item to the pushed view controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if( [sender isKindOfClass:[CercaPixGalleryViewController class]])
    {
        
    // cast destination vc to our gallery type
        CercaPixGalleryViewController *gvController = (CercaPixGalleryViewController*) segue.destinationViewController;
        
    // set the imageInfo object on the view controller
        gvController.selectedImageInfo = selectedAnnotation.imageInfo;
    }
 
}

#pragma mark mapview delegate methods

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation*) userLocation
{
    
    
}

// KVO implementation of observeValueForKeyPath for mapview.userLocation.location (CLLocation)

/* a 'change' dictionary looks like:
 
 kind = 1;
 new = "+40.65828417,-73.97746150 +/- 904.04m (speed -1.00 mps / course -1.00) @ 4/21/14, 9:57:58 AM Eastern Daylight Time";
 old = "+40.65942461,-73.97937125 +/- 10.00m (speed 0.00 mps / course -1.00) @ 4/21/14, 9:57:28 AM Eastern Daylight Time";
 
 */
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    
    // intention is, the first time we get a fix to zoom to the user's location
    // and put it on the map in a nice viewable region.
    static BOOL firstLoad = false;
    
    [CercaPixController sharedInstance].searchOriginLocation = self.mMapView.userLocation.location;
    
    if(!firstLoad)
    {
        
        // if this method was called, then we got a fix,
        // so tell the user.
        [self statusMessage:[NSString stringWithFormat:@"Got a fix at %.2f,%.2f",
                                  self.mMapView.userLocation.coordinate.latitude,
                                  self.mMapView.userLocation.coordinate.longitude]
                     timeOut:2.0];
        
        firstLoad = true;
        
        // center map on the preferred radius
        [self.mMapView centerOnRadius:[CercaPixController sharedInstance].preferredSearchRadius];
        
        // draw the circle of what their radius is
        [self addCircle];
        
        [self statusMessage:@"Searching for photos... " timeOut:15.0f];
        [[CercaPixController sharedInstance] getNearbyPhotos];
        
        
    }
    
    // store our location in the app controller
    
}

-(void) addCircle
{
    
        MKCircle *circle = [MKCircle
               circleWithCenterCoordinate:self.mMapView.userLocation.coordinate
               radius:[CercaPixController sharedInstance].preferredSearchRadius];
        
        [self.mMapView addOverlay:circle];
    
}


#pragma mark mapkit delegate


-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if ( [view isKindOfClass:[CercaPixAnnotationView class]])
    {
        selectedAnnotation = (CercaPixAnnotation*)view.annotation;
    }
    else
    {
        // happens when user touches user location, e.g.
        selectedAnnotation = nil;
    }
}


-(void) mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self statusMessage:error.description timeOut:3.0f];
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                            calloutAccessoryControlTapped:(UIControl *)control
{
    
    // LOGV(@"Detail id: %@", view.annotation);
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    
    
    // our custom annotation
    // if we match our class
    if ([annotation isKindOfClass:[CercaPixAnnotation class]]) {
        
        CercaPixAnnotation *cpannotation = (CercaPixAnnotation*) annotation;
        
        CercaPixAnnotationView *annotationView = (CercaPixAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CercaPixAnnotationView"];
        
        if (!annotationView) {
            
            // none found so create new
            annotationView = [[CercaPixAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:@"CercaPixAnnotationView"];
            
            // add detail button
            annotationView.canShowCallout = YES;
            
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [rightButton addTarget:self action:@selector(showDetails:)
              forControlEvents:UIControlEventTouchUpInside];
        
        annotationView.rightCalloutAccessoryView = rightButton;
            // add the thumbnail + set associated object
        UIImageView *thumbnail = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 48.0f, 48.0f)];
        [thumbnail downloadImageFromUrl:cpannotation.imageInfo.thumbnailUrl];
        annotationView.leftCalloutAccessoryView  = thumbnail;
        
        return annotationView;
    }
    
    
    
    return nil;
    
}

#pragma mark MKOverlay protocol

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay
{
    
    // if the user touches the map only, go to details page with no image selected
    // if the user touches an annotation, show the annotation
    if( [overlay isKindOfClass:[MKCircle class]])
    {
        
        MKCircle *circle = [MKCircle
                            circleWithCenterCoordinate:_mMapView.userLocation.location.coordinate
                            radius:[CercaPixController sharedInstance].preferredSearchRadius];
    
        MKCircleRenderer *circlerenderer = [[MKCircleRenderer alloc] initWithCircle:circle];
        circlerenderer.strokeColor = [[UIColor darkGreenColor] colorWithAlphaComponent:0.3f];
        circlerenderer.lineWidth = 1.5;
        return circlerenderer;
    }
    return nil;
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay
{
    
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers
{
}


- (IBAction)sliderValueChanged:(UISlider *)sender
{
    
    NSArray *annotations = self.mMapView.annotations;
    if( annotations.count > 0)
    {
        [_mMapView removeAnnotations:annotations];
    }
    [self.mMapView removeOverlays:self.mMapView.overlays];
    [self.mMapView centerOnRadius:sender.value];
    
    CGFloat kilometers = (sender.value/1000);
    self.mKmLabel.text = [NSString stringWithFormat:@"%.2fkm",kilometers];
}

- (IBAction)sliderTouchEnded:(UISlider*)sender {
    
    [CercaPixController sharedInstance].preferredSearchRadius = sender.value;
    [self addCircle];
    [[CercaPixController sharedInstance] getNearbyPhotos];
    [self statusMessage:@"Searching for photos... " timeOut:15.0f];
    
}

-(void) handleTapGesture:(UITapGestureRecognizer*) gestureRecognizer
{
    if( gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        
        CGPoint locInView = [gestureRecognizer locationInView:self.mMapView];
        id obj = [self.mMapView hitTest:locInView withEvent:nil];
        if ([obj isKindOfClass:[CercaPixAnnotationView class]])
        {
            
            // do not handle tap gesture
            return;
        }
        else if ( [obj isKindOfClass:[UIView class]])
        {
            [self showDetails:nil];
        }
        else
        {
        }
    }
}

// deselect animations

-(void) deselectAllAnnotations
{
    
    for( CercaPixAnnotation *annotation in self.mMapView.selectedAnnotations)
    {
        [self.mMapView deselectAnnotation:annotation animated:NO];
        
    }
    selectedAnnotation = nil;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [self deselectAllAnnotations];
}

-(void) showDetails:(id) sender
{
    // push the gallery view controller
    
    
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}


-(void) statusMessage:(NSString*)text timeOut:(CGFloat) timeout
{
    
    if( [mMessageTimer isValid] )
    {
        [mMessageTimer invalidate];
    }
    
    _mStatusLabel.text = text;
    [_mStatusBarView show];
    
    mMessageTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(hideMessage:) userInfo:Nil repeats:NO];
    
}



-(void) hideMessage:(NSTimer*) timer
{
    _mStatusLabel.text = @"";
    [_mStatusBarView hide];
}


#pragma mark location manager delegate

-(void)locationManager:(CLLocationManager *)manager
        didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            break;
            
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            [self statusMessage:@"Cannot search for photos" timeOut:3.0f];
            break;
        default:
            break;
    }
    
}


-(void) dealloc
{
    [self.mMapView.userLocation removeObserver:self forKeyPath:@"location"];
    self.mMapView.delegate = nil;
    [self.mMapView removeFromSuperview];
    self.mMapView = nil;

}


@end