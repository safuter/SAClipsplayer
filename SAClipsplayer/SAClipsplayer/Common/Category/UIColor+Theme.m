//
//  UIColor+Theme.m
//  KPJokesApp
//
//  Created by Finup on 2018/7/16.
//  Copyright © 2018年 Finup. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

UIColor* colorFromHex(NSString * hexString){
    UIColor *color = colorFromHexAndAlpha(hexString, 1.0);
    return color;
}

UIColor* colorFromHexAndAlpha(NSString * hexString,CGFloat alpha){
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexInt & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexInt & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexInt & 0xFF))/255
                    alpha:alpha > 1.0 ? 1.0 : alpha];
    
    return color;
}


@end
