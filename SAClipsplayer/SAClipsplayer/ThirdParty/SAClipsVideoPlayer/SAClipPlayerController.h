//
//  SAClipPlayerController.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAClipPlayerToftView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SAClipPlayerControllerDelegate <NSObject>

/// 指定视频列表页视频view 用于转场动画的起始frame
- (UIView *)sourceContainerView;

@end

@interface SAClipPlayerController : UIViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *corverImgUrl;
@property (nonatomic, assign) CGFloat videoScale;
@property (nonatomic, strong) SAClipPlayerToftView *toftView;

@property (nonatomic, weak) id<SAClipPlayerControllerDelegate> delegate;
@property (nonatomic, strong) UIView *sourceContainerView;

/**
 初始化player控制器对象

 @param playUrlStr 视频资源的url路径
 @param corverUrlStr 封面图片的url路径
 @return player控制器对象
 */
- (instancetype)initWithPlayUrlStr:(NSString *)playUrlStr
                      corverUrlStr:(NSString *)corverUrlStr
                        videoScale:(CGFloat)videoScale;

@end

NS_ASSUME_NONNULL_END
