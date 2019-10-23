//
//  SAClipPlayerToftView.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAClipPlayerToftView.h"

@interface SAClipPlayerToftView()


@end

@implementation SAClipPlayerToftView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"toft view dealloc");
    _playerScreenView = nil;
}

- (void)setupViews {
    
    _corverImageView = [[UIImageView alloc] init];
    _corverImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_corverImageView];
    
    _playerScreenView = [[SAClipPlayerScreenView alloc] init];
    [self addSubview:_playerScreenView];
    
    self.backgroundColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _corverImageView.frame = self.bounds;
    _playerScreenView.frame = self.bounds;
    _handleView.frame = self.bounds;
}

- (void)setPlayer:(AVPlayer *)player {
    _playerScreenView.playerLayer.player = player;
}

- (void)setHandleView:(SAClipPlayerHandleView *)handleView {
    if (self.handleView) {
        [self.handleView removeFromSuperview];
        self.handleView = nil;
    }
    _handleView = handleView;
    [self addSubview:handleView];
}

- (void)setCorverImageUrl:(NSString *)corverImageUrl {
    _corverImageUrl = corverImageUrl;
    [_corverImageView sd_setImageWithURL:[NSURL URLWithString:self.corverImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
