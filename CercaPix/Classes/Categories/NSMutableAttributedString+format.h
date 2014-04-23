
/**
 * Category on NSMutableAttributed string to set formatting
 *
 * method names are pretty self-explanatory
 *
 */


#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (formatting)
-(void) setLineSpacing:(int) lineSpacing;
-(void) setFont:(NSString*) fontName size:(CGFloat) fontSize;
-(void) setBackgroundColor:(UIColor*) color;
-(void) setColor:(UIColor*) color;
-(NSMutableAttributedString*) concat:(NSAttributedString*)string1;

@end
