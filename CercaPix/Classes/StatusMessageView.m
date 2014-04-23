//
//  StatusMessageView.m
//  CercaPix
//
//  Created by kramden.com on 4/22/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "StatusMessageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StatusMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.layer.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4].CGColor;
        self.layer.cornerRadius = 8.0f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 24.0f;;
        self.layer.shadowOpacity = 0.5;
        
        _label = [[UILabel alloc]initWithFrame:
                      CGRectInset(self.bounds, 10.0f, 10.0f)];
        _label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        _label.numberOfLines = 10;
        _label.center = self.center;
        [self addSubview:_label];
    }
    return self;
}





@end
