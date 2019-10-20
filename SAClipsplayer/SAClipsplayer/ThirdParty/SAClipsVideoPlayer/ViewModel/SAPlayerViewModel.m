//
//  SAPlayerViewModel.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAPlayerViewModel.h"

@implementation SAPlayerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

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
    
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
    //监控缓冲加载情况属性
    [_player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                // 开始播放
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [_player play];
//                    self.playerView.hidden = NO;
//                });
                [_player play];
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
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
}

@end
