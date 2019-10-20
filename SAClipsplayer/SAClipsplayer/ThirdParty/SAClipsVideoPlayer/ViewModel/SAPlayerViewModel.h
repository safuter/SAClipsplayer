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

@interface SAPlayerViewModel : NSObject

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;

- (instancetype)initWithUrlStr:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
