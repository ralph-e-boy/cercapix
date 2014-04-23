//
//  CercaPixAnnotationView.m
//  CercaPix
//
//  Created by kramden.com on 4/20/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "CercaPixAnnotationView.h"
#import "UIView+effects.h"

@implementation CercaPixAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.image = [UIImage imageNamed:@"cameraicon"];
        
        CGRect  myFrame = self.frame;
        myFrame.size.width = 36;
        myFrame.size.height = 36;
        self.frame = myFrame;
        
    }
    return self;
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
