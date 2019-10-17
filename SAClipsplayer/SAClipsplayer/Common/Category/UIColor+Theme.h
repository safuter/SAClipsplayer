//
//  UIColor+Theme.h
//  KPJokesApp
//
//  Created by Finup on 2018/7/16.
//  Copyright © 2018年 Finup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

/*
 * @Sylar
 *
 * 16进制字符串生成颜色对象.   e.g #FF0011 = (255,0,17)
 */
UIColor* colorFromHex(NSString * hexString);

/*
 * @Sylar
 *
 * 16进制字符串生成颜色对象,alpha 透明度alpha < 1.0
 */
UIColor* colorFromHexAndAlpha(NSString * hexString,CGFloat alpha);


@end
