//
//  SAClipPlayerToftView.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SAClipPlayerHandleView.h"
#import "SAClipPlayerScreenView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAClipPlayerToftView : UIView
@property (nonatomic, strong) NSString *corverImageUrl;
@property (nonatomic, strong) UIImageView *corverImageView;
@property (nonatomic, strong, nullable) SAClipPlayerHandleView *handleView;
@property (nonatomic, strong) SAClipPlayerScreenView *playerScreenView;

/**
 赋值player

 @param player viewmodel中的player对象
 */
- (void)setPlayer:(AVPlayer *)player;
@end

NS_ASSUME_NONNULL_END
