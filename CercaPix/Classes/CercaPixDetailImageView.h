//
//  CercaPixDetailImageView.h
//  CercaPix
//
//  Created by kramden.com on 4/22/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CercaPixDetailImageView : UIView

@property (nonatomic,retain)IBOutlet UIImageView *imageView;
@property (nonatomic,retain)IBOutlet UILabel *title;
@property (nonatomic,retain)IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *subcaption;

@end
