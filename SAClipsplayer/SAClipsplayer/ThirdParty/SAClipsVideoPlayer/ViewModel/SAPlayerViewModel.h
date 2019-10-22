//
//  SAPlayerViewModel.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SA_NOTIFICATION_NAME_START_ACTIVITY;
extern NSString *const SA_NOTIFICATION_NAME_STOP_ACTIVITY;

typedef enum : NSUInteger {
    SAPlayStateUnKnown,
    SAPlayStatePlaying,
    SAPlayStatePaused,
    SAPlayStateEnded,
} SAPlayState;

typedef void(^SAPlayStateChangeBlock)(SAPlayState playState);

@interface SAPlayerViewModel : NSObject

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, assign) SAPlayState playState;

@property (nonatomic, copy) SAPlayStateChangeBlock playStateChanged;

- (instancetype)initWithUrlStr:(NSString *)urlStr;

- (void)play;
- (void)pause;
@end

NS_ASSUME_NONNULL_END
