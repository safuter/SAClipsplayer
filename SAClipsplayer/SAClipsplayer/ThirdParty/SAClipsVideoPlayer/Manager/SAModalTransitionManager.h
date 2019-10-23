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

@interface SAModalTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) SAClipPlayerController *playerController;
@end

NS_ASSUME_NONNULL_END
