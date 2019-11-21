//
//  SAUtility.m
//  SAClipsplayer
//
//  Created by zheng on 2019/11/21.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAUtility.h"

@implementation SAUtility
+ (UIWindow *)getCurrentWindow {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *))
    {
        window = [[UIApplication sharedApplication].windows firstObject];
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

@end
