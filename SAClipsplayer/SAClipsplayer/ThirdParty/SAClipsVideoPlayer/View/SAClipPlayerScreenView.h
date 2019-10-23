//
//  SAClipPlayerScreenView.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAClipPlayerScreenView : UIView
@property (nonatomic, readonly, strong) AVPlayerLayer *playerLayer;
@end

NS_ASSUME_NONNULL_END
