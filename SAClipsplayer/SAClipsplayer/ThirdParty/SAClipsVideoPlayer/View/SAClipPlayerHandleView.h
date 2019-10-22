//
//  SAClipPlayerHandleView.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAPlayerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SAClipPlayerHandleViewDelegate <NSObject>
- (void)playOrPauseAction:(UIButton *)sender;
@end

@interface SAClipPlayerHandleView : UIView
/// 是否显示控制view
@property (nonatomic, assign) BOOL showControlView;

@property (nonatomic, assign) SAPlayState playState;

@property (nonatomic, weak) id <SAClipPlayerHandleViewDelegate> delegate;

- (void)startActivity;
- (void)stopActivity;
@end

NS_ASSUME_NONNULL_END
