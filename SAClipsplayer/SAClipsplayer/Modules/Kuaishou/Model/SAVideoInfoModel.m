//
//  SAVideoInfoModel.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAVideoInfoModel.h"

@implementation SAVideoInfoModel

- (CGFloat)videoScale {
    if (self.width > 0 && self.height > 0) {
        return  (CGFloat)self.height / self.width;
    }
    return 1.0;
}

@end
