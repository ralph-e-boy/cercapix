//
//  CercaPixGalleryViewController.h
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CercaPixGalleryViewController : UICollectionViewController
@property (strong, nonatomic) IBOutlet UICollectionView *galleryCollectionView;

@property (nonatomic,retain) NSDictionary *selectedImageInfo;

@end
