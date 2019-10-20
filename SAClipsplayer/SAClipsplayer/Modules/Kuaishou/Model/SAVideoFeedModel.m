//
//  SAVideoFeedModel.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAVideoFeedModel.h"

@implementation SAVideoFeedModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"videos" : @"SAVideoInfoModel"
             };
}

- (SAVideoInfoModel *)video {
    return self.videos.firstObject;
}

@end
