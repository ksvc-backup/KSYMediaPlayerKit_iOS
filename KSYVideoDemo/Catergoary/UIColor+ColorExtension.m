//
//  UIColor+ColorExtension.m
//  MRColor
//
//  Created by Mr.Yang on 13-7-26.
//  Copyright (c) 2013年 Hunter. All rights reserved.
//

#import "UIColor+ColorExtension.h"

@implementation UIColor (ColorExtension)

+ (UIColor *)colorWithHEX:(uint)color
{
    float r = (color&0xFF0000) >> 16;
    float g = (color&0xFF00) >> 8;
    float b = (color&0xFF);
    return [UIColor flashColorWithRed:r green:g blue:b alpha:1.0f];
}

+ (NSArray*)colorForHex:(NSString *)hexColor
{
	hexColor = [[hexColor stringByTrimmingCharactersInSet:
				 [NSCharacterSet whitespaceAndNewlineCharacterSet]
				 ] uppercaseString];
	
    NSRange range;
    range.location = 0;
    range.length = 2;
	
    NSString *rString = [hexColor substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	NSArray *components = [NSArray arrayWithObjects:[NSNumber numberWithFloat:((float) r / 255.0f)],[NSNumber numberWithFloat:((float) g / 255.0f)],[NSNumber numberWithFloat:((float) b / 255.0f)],[NSNumber numberWithFloat:1.0],nil];
	return components;
}

+ (UIColor *)randomColor
{
    float r = (double)arc4random()/0x100000000;
    float g = (double)arc4random()/0x100000000;
    float b = (double)arc4random()/0x100000000;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)flashColorWithRed:(uint)red green:(uint)green blue:(uint)blue alpha:(float)alpha
{
    float r = red/255.0f;
    float g = green/255.0f;
    float b = blue/255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)colorWithPatternImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return [UIColor colorWithPatternImage:image];
    }
    return nil;
}

#pragma mark 16#转rgb 郭海彬增加
+  (UIColor *) callColorFromHexRGB:(NSString *) inColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end
