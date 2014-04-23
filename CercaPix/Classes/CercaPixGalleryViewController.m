//
//  CercaPixGalleryViewController.m
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "CercaPixGalleryViewController.h"
#import "CercaPixController.h"
#import "CercaPixGalleryViewCell.h"
#import "CercaPixDetailImageView.h"
#import "NSDictionary+instagram_api.h"
#import "UIImageView+download.h"
#import "UIView+effects.h"
#import "UIColor+unixcolors.h"
#import "NSMutableAttributedString+format.h"

@interface CercaPixGalleryViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    // this is the UIVIew that displays a photo
    CercaPixDetailImageView *detailImageView;
    
}
- (IBAction)popToMap:(id)sender;

@end

@implementation CercaPixGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.useLayoutToLayoutNavigationTransitions = YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.galleryCollectionView.delegate = self;
    self.galleryCollectionView.dataSource = self; //[CercaPixController sharedInstance];
    
    detailImageView = [[[NSBundle mainBundle] loadNibNamed:@"CercaPixDetailImageView" owner:self options:nil] objectAtIndex:0];
    
    // offset for ipad
    if ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        detailImageView.center = self.view.center;
    }
    
    // handle taps on the detail view
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetailImage:)];
    [detailImageView addGestureRecognizer:gr];
    
    UISwipeGestureRecognizer *lswipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    lswipegr.direction = UISwipeGestureRecognizerDirectionLeft;
    [detailImageView addGestureRecognizer:lswipegr];
    
    UISwipeGestureRecognizer *rswipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rswipegr.direction = UISwipeGestureRecognizerDirectionRight;
    [detailImageView addGestureRecognizer:rswipegr];
    
    
    [detailImageView hide];
    [self.view addSubview:detailImageView];
    
    
    
}

// handles both swipe left and right
// to page through images with a visual flip

-(void) handleSwipe:(UISwipeGestureRecognizer* ) gr

{
    if(gr.state == UIGestureRecognizerStateEnded)
    {
        
        NSDictionary *result = nil;
        
        
        NSIndexPath *indexPath = [self.galleryCollectionView.indexPathsForSelectedItems firstObject];
        
        if(!(indexPath))
        {
            return;
        }
        
        NSIndexPath *newindexPath = nil;
        
        int nEntries = [self.galleryCollectionView numberOfItemsInSection:0];
        
        if(gr.direction == UISwipeGestureRecognizerDirectionRight)
        {
            newindexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
            
            if(indexPath.row < 1)
            {
                newindexPath=[NSIndexPath indexPathForRow:nEntries-1 inSection:indexPath.section];
            }
            
            result = [[[CercaPixController sharedInstance] searchResults]
                                objectAtIndex:newindexPath.row];
            
            
            // eye candy
            [UIView transitionWithView:detailImageView.imageView
                              duration:0.3
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^ { detailImageView.imageView.alpha = 0.0; }
                            completion:^(BOOL complete){
                                if(complete)
                                {
                                 [self updateDetailData:result];
                                }
                            }];
            
            
        }
        else if(gr.direction == UISwipeGestureRecognizerDirectionLeft) // advance
        {
            
            // path to increment
            newindexPath=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            
            
            if(indexPath.row == nEntries-1)
            {
                newindexPath=[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
            }
            
            result = [[[CercaPixController sharedInstance] searchResults]
                                objectAtIndex:newindexPath.row];
            
            // eye candy
            [UIView transitionWithView:detailImageView.imageView
                              duration:0.3
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:^ { detailImageView.imageView.alpha = 0.0; }
                            completion:^(BOOL complete){
                                if(complete)
                                {
                                 [self updateDetailData:result];
                                }
                            }];
            
        }
        
        
        // interestingly this does not call gesture delegate.
        [self.galleryCollectionView selectItemAtIndexPath:newindexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        
    }
    
}

-(void) hideDetailImage:(UIGestureRecognizer* ) gr
{
    if(gr.state == UIGestureRecognizerStateEnded)
    {
        [detailImageView hide];
    }
}


-(void) viewDidAppear:(BOOL)animated
{
    // show the image that was selected
    if( self.selectedImageInfo)
    {
        [self updateDetailData:self.selectedImageInfo];
        [detailImageView show];
    }
}

-(void) updateDetailData:(NSDictionary*)imageInfo
{
    
        // set a blank placeholder
        [detailImageView.imageView blackPlaceholder];
    
        detailImageView.hidden = YES;
        detailImageView.imageView.alpha = 1.0f;
    
        // tell the imageview to download the image at url xyz from the result item
        [detailImageView.imageView downloadImageFromUrl:imageInfo.standardResUrl];
    
        CLLocation *photoLoc   = [[CLLocation alloc] initWithLatitude:imageInfo.latitude
                                                        longitude:imageInfo.longitude];
        // get distance from search center
        CLLocationDistance distanceInKm = [[CercaPixController sharedInstance]
                                           getPhotoDistance:photoLoc.coordinate];
    
        NSMutableAttributedString *byline = [[NSMutableAttributedString alloc]
                                             initWithString:@"by "];
    
        [byline setColor:[UIColor slateBlue1Color]];
        [byline setFont:@"HelveticaNeue" size:20.0f];
    
        NSMutableAttributedString *userstring = [[NSMutableAttributedString alloc]
                                             initWithString:imageInfo.username];
        [userstring setColor:[UIColor slateGray1Color]];
        byline = [byline concat:userstring];
    
        detailImageView.title.attributedText = byline;
        detailImageView.caption.text = [NSString stringWithFormat:@"%@", imageInfo.caption];
        detailImageView.subcaption.text = [NSString stringWithFormat:@"%.2fkm",distanceInKm];
        [detailImageView show];
    
}


-(void) viewWillAppear:(BOOL)animated
{
    [self.galleryCollectionView reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (NSInteger) [[[CercaPixController sharedInstance] searchResults] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellReuseIdentifier";
    
    CercaPixGalleryViewCell *cell = (CercaPixGalleryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *result = [[[CercaPixController sharedInstance] searchResults]
                            objectAtIndex:indexPath.row];
    
    // tell the imageview to download the image at url xyz from the result item
    [cell.imageView downloadImageFromUrl:result.lowResUrl];
    
    return cell;
    
}

#pragma mark CollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView
            didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *result = [[[CercaPixController sharedInstance] searchResults]
                            objectAtIndex:indexPath.row];
    
    [self updateDetailData:result];
    
    [detailImageView show];
    
}

-(void)collectionView:(UICollectionView *)collectionView
            didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

    CercaPixGalleryViewCell *cell = (CercaPixGalleryViewCell*)[self.galleryCollectionView
                                     cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)popToMap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
