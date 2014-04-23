//
//  NSMutableAttributedString+format.m
//  CercaPix
//
//  Created by kramden.com on 4/22/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "NSMutableAttributedString+format.h"


@implementation NSMutableAttributedString (format)


-(NSMutableAttributedString*) concat:(NSAttributedString*) string1
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithAttributedString:self];
    
    [result appendAttributedString:string1];
    
    return result;
}

-(void) setFont:(NSString*) fontName size:(CGFloat) fontSize {
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self addAttributes:dict range:NSMakeRange(0, self.length)];
}

-(void) setColor:(UIColor*) color {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    [self addAttributes:dict range:NSMakeRange(0, self.length)];
}

-(void) setBackgroundColor:(UIColor*) color {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:NSBackgroundColorAttributeName];
    [self addAttributes:dict range:NSMakeRange(0, self.length)];
}

-(void) setLineSpacing:(int) lineSpacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpacing];
    [self addAttribute:NSParagraphStyleAttributeName
                 value:style
                 range:NSMakeRange(0, self.length)];
}

@end
