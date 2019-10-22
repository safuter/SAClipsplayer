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

NS_ASSUME_NONNULL_BEGIN

@interface SAClipPlayerToftView : UIView
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSString *corverImageUrl;
@property (nonatomic, strong) UIImageView *corverImageView;
@property (nonatomic, strong, nullable) SAClipPlayerHandleView *handleView;
@end

NS_ASSUME_NONNULL_END
