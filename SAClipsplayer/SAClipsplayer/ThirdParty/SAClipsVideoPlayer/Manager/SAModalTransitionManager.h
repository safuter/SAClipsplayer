//
//  SAModalTransitionManager.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/22.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAClipPlayerController.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 侧滑返回效果
    SAVideoFeedTransitionTypeSlide,
    /// 拖拽返回效果
    SAVideoFeedTransitionTypeMove,
} SAVideoFeedTransitionType;

@interface SAModalTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) SAClipPlayerController *playerController;
@property (nonatomic, assign) SAVideoFeedTransitionType animationType;
@end

NS_ASSUME_NONNULL_END
