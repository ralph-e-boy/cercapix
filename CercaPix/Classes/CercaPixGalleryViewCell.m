//
//  CercaPixGalleryViewCell.m
//  CercaPix
//
//  Created by kramden.com on 4/21/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "CercaPixGalleryViewCell.h"
#import "UIColor+unixcolors.h"


@interface CercaPixGalleryViewCell()

/**
 * initialize the custom views that are used in this 
 * colllectionview subclass, i.e. selected bgview, imageview, etc
 */

-(void) initSubviews;

@end

@implementation CercaPixGalleryViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
        // Initialization code
    }
    return self;
}

-(void) initSubviews
{
    
    CGRect imagerect = CGRectInset(self.bounds, 6, 6);
    self.imageView = [[UIImageView alloc]initWithFrame:imagerect];
    self.imageView.layer.cornerRadius = 4.0;
    UIView *bgview = [[UIView alloc]initWithFrame:self.bounds];
    bgview.layer.cornerRadius = 4.0;
    self.backgroundView = bgview;
    self.backgroundView.backgroundColor = [[UIColor aquamarine4Color] colorWithAlphaComponent:0.3];
    self.selectedBackgroundView =[[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [[UIColor aquamarine1Color]colorWithAlphaComponent:0.3];
    [self.contentView addSubview:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
