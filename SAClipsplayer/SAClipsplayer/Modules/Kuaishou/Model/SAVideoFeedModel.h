//
//  SAVideoFeedModel.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAVideoInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAVideoFeedModel : NSObject
@property (nonatomic, strong) NSArray<SAVideoInfoModel *> *videos; // 视频数组
@property (nonatomic, strong) NSString *content;
@end

NS_ASSUME_NONNULL_END
