//
//  SAPlayerViewModel.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAPlayerViewModel.h"

// notification
NSString *const SA_NOTIFICATION_NAME_START_ACTIVITY = @"SA_NOTIFICATION_NAME_START_ACTIVITY";
NSString *const SA_NOTIFICATION_NAME_STOP_ACTIVITY  = @"SA_NOTIFICATION_NAME_STOP_ACTIVITY";

// player item kvo property
NSString *const KStatus = @"status";
NSString *const KPlaybackBufferEmpty = @"playbackBufferEmpty";
NSString *const KLoadedTimeRanges = @"loadedTimeRanges";
NSString *const kPlaybackLikelyToKeepUp = @"playbackLikelyToKeepUp";

@interface SAPlayerViewModel()
@property (nonatomic, strong) dispatch_block_t startLoadActivityBlock;
@property (nonatomic, strong) dispatch_block_t startActivityBlock;
@property (nonatomic, strong) dispatch_block_t stopActivityBlock;
@end

@implementation SAPlayerViewModel

- (instancetype)initWithUrlStr:(NSString *)urlStr {
    if (self = [super init]) {
        _urlStr = urlStr;
        [self setupAvPlayer];
    }
    return self;
}

- (void)setupAvPlayer {
    NSAssert(_urlStr, @"player url can not be nil");
    
    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_urlStr]];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [_playerItem addObserver:self forKeyPath:KStatus options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
    //监控缓冲加载情况属性
    [_player.currentItem addObserver:self forKeyPath:KLoadedTimeRanges options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:KPlaybackBufferEmpty options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:kPlaybackLikelyToKeepUp options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemPlayToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    
    // 开始缓冲的Block 1s内没有开始播放则执行该block 展示loadng动画
    _startLoadActivityBlock = dispatch_block_create(0, ^{
        NSLog(@"activity");
        [[NSNotificationCenter defaultCenter] postNotificationName:SA_NOTIFICATION_NAME_START_ACTIVITY object:nil];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.startLoadActivityBlock();
        });
    });
    
    _startActivityBlock = dispatch_block_create(0, ^{
        NSLog(@"activity");
        [[NSNotificationCenter defaultCenter] postNotificationName:SA_NOTIFICATION_NAME_START_ACTIVITY object:nil];
    });
    
    _stopActivityBlock = dispatch_block_create(0, ^{
        NSLog(@"stopactivity");
        [[NSNotificationCenter defaultCenter] postNotificationName:SA_NOTIFICATION_NAME_STOP_ACTIVITY object:nil];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:KStatus]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        
        dispatch_block_cancel(self.startLoadActivityBlock);
        if (self.stopActivityBlock) {
            self.stopActivityBlock();
        }
        
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                
                // 开始播放
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [_player play];
//                    self.playerView.hidden = NO;
//                });
                [_player play];
                self.playState = SAPlayStatePlaying;
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                NSLog(@"加载失败");
                NSLog(@"错误原因:%@",_player.error.description);
            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                NSLog(@"未知资源");
            }
                break;
            default:
                break;
        }
    } else if ([keyPath isEqualToString:KLoadedTimeRanges]) {
        
    } else if ([keyPath isEqualToString:KPlaybackBufferEmpty]) {
        if (self.startActivityBlock) {
            self.startActivityBlock();
            NSLog(@"------buffer empty");
        }
    } else if ([keyPath isEqualToString:kPlaybackLikelyToKeepUp]) {
        if (self.playerItem.playbackLikelyToKeepUp) {
            if (self.stopActivityBlock) {
                self.stopActivityBlock();
                NSLog(@"------likely to keepup");
            }
        }
    }
}

#pragma mark - Public
- (void)play {
    [self.player play];
    self.playState = SAPlayStatePlaying;
}

- (void)pause {
    [self.player pause];
    self.playState = SAPlayStatePaused;
}

- (void)itemPlayToEnd {
    [self.playerItem seekToTime:CMTimeMakeWithSeconds(0, 600)];
}

- (void)setPlayState:(SAPlayState)playState {
    _playState = playState;
    if (self.playStateChanged) {
        self.playStateChanged(playState);
    }
}

@end
