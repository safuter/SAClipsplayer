//
//  SAClipPlayerController.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAClipPlayerController : UIViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *corverImgUrl;


/**
 初始化player控制器对象

 @param playUrlStr 视频资源的url路径
 @param corverUrlStr 封面图片的url路径
 @return player控制器对象
 */
- (instancetype)initWithPlayUrlStr:(NSString *)playUrlStr
                      corverUrlStr:(NSString *)corverUrlStr;

@end

NS_ASSUME_NONNULL_END
