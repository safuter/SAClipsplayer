//
//  SAClipPlayerScreenView.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

/// 用于直接显示视频内容

#import "SAClipPlayerScreenView.h"
#import <AVFoundation/AVFoundation.h>

@implementation SAClipPlayerScreenView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"screen view dealloc");
}

- (void)setupViews {
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}

#pragma mark - Getter
- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}



@end
